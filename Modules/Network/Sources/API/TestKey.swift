import Dependencies
import Foundation

extension APIClient: TestDependencyKey {
  public static var testValue: APIClient = .init(
    request: unimplemented("\(Self.self).request")
  )
}
