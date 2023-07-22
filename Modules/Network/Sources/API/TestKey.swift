import Dependencies
import Foundation

extension APIClient: TestDependencyKey {
  public static var testValue: APIClient = .init(
    request: unimplemented("\(Self.self).request")
  )
}

#if DEBUG
public func mockResponse(
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
#endif
