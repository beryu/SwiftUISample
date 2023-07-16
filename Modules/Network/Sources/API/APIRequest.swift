import Foundation

public protocol APIRequest: Equatable {
  associatedtype Response: Decodable

  var baseURL: URL? { get }
  var path: String { get }
  var method: APIMethod { get }
  var headerDict: [String: String] { get }
  var queryParams: [String: String?] { get }

  func urlRequest() -> URLRequest?
  func request(urlSession: URLSession) async throws -> Response
}

public extension APIRequest {
  func urlRequest() -> URLRequest? {
    guard let baseURL else {
      return nil
    }
    var urlComponents = URLComponents(
      url: baseURL.appendingPathComponent(path),
      resolvingAgainstBaseURL: false
    )
    let queryItems: [URLQueryItem] = queryParams.compactMap { (key: String, value: String?) in
      guard let value else {
        return nil
      }
      return .init(name: key, value: value)
    }
    if !queryItems.isEmpty {
      urlComponents?.queryItems = queryItems
    }
    guard let url = urlComponents?.url else {
      return nil
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    for (field, value) in headerDict {
      urlRequest.addValue(
        value,
        forHTTPHeaderField: field
      )
    }
    return urlRequest
  }

  func request() async throws -> Response {
    try await request(urlSession: .shared)
  }

  func request(urlSession: URLSession) async throws -> Response {
    guard let urlRequest = urlRequest() else {
      throw APIError.badURL
    }
    let (data, urlResponse) = try await urlSession.data(for: urlRequest)
    guard let httpResponse = urlResponse as? HTTPURLResponse else {
      // Maybe a bug
      throw APIError.unknown
    }
    // Accept http status codes only in 200 - 399
    guard (200 ..< 400).contains(httpResponse.statusCode) else {
      throw APIError.failureWithStatusCode(httpResponse.statusCode)
    }

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    do {
      return try decoder.decode(Response.self, from: data)
    } catch {
      throw APIError.responseParseError(error)
    }
  }
}
