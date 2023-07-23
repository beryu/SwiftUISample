import Foundation
import Dependencies

public protocol APIClient {
  func request<T: APIRequest>(apiRequest: T) async throws -> T.Response
}
