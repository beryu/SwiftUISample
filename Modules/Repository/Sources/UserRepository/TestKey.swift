import Dependencies
import XCTestDynamicOverlay

extension UserRepository: TestDependencyKey {
  public static var testValue = Self(
    searchUsers: unimplemented("\(Self.self).searchUsers")
  )
}
