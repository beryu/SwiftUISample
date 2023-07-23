import Dependencies
import Foundation

extension APIClientKey: TestDependencyKey {
  public static var testValue: any APIClient = APIClientImpl(urlSession: .shared)
}

#if DEBUG
func mockResponse(
  value: String = "",
  statusCode: Int = 200
) -> (Data, URLResponse) {
  (
    value.data(using: .utf8)!,
    HTTPURLResponse(
      url: .init(string: "/")!,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil
    )!
  )
}

public struct APIClientMock: APIClient {
  public var response: [Int: Any]

  public init(response: [Int: Any]) {
    self.response = response
  }

  public func request<T: APIRequest>(apiRequest: T) async throws -> T.Response {
    let key = apiRequest.hashValue
    return response[key] as! T.Response
  }
}
#endif
