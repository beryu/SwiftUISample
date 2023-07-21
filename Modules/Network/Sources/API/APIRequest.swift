import Foundation

public protocol APIRequest: Equatable {
  associatedtype Response: Decodable

  var baseURL: URL? { get }
  var path: String { get }
  var method: APIMethod { get }
  var headerDict: [String: String] { get }
  var queryParams: [String: String?] { get }

  func urlRequest() -> URLRequest?
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
}
