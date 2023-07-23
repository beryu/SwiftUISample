import Foundation
import Dependencies

public enum APIClientKey: DependencyKey {
  public static var liveValue: any APIClient = APIClientImpl(urlSession: .shared)
}

extension DependencyValues {
  public var apiClient: any APIClient {
    get { self[APIClientKey.self] }
    set { self[APIClientKey.self] = newValue }
  }
}

struct APIClientImpl: APIClient {
  private var urlSession: URLSession

  init(urlSession: URLSession) {
    self.urlSession = urlSession
  }

  func request<T: APIRequest>(apiRequest: T) async throws -> T.Response {
    guard let urlRequest = apiRequest.urlRequest() else {
      throw APIError.badURL
    }
    let (data, urlResponse) = try await request(urlRequest: urlRequest)
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

  private func request(urlRequest: URLRequest) async throws -> (Data, URLResponse) {
    try await urlSession.data(for: urlRequest)
  }
}
