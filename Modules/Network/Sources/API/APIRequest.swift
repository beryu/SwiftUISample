import Foundation

public protocol APIRequest: Equatable {
  associatedtype Response: Decodable

  var baseURL: URL { get }
  var path: String { get }
  var method: APIMethod { get }
  var headerDict: [String: String] { get }

  func urlRequest() -> URLRequest
  func request(urlSession: URLSession) async throws -> Response
}

public extension APIRequest {
  func urlRequest() -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
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
    let urlRequest = urlRequest()
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
    do {
      return try decoder.decode(Response.self, from: data)
    } catch {
      throw APIError.responseParseError(error)
    }
  }
}
