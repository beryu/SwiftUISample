import Foundation
import Dependencies

extension APIClient {
  static func live(urlSession: URLSession) -> Self {
    .init(
      request: { urlRequest in
        try await urlSession.data(for: urlRequest)
      }
    )
  }

  public func request<T: APIRequest>(_ apiRequest: T) async throws -> T.Response {
    guard let urlRequest = apiRequest.urlRequest() else {
      throw APIError.badURL
    }
    let (data, urlResponse) = try await request(urlRequest)
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
      return try decoder.decode(T.Response.self, from: data)
    } catch {
      throw APIError.responseParseError(error)
    }
  }
}
