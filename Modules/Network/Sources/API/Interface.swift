import Foundation
import Dependencies

public struct APIClient {
  public var request: (URLRequest) async throws -> (Data, URLResponse)

  public init(request: @escaping (URLRequest) async throws -> (Data, URLResponse)) {
    self.request = request
  }
}

public extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
