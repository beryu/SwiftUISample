import Dependencies
import XCTestDynamicOverlay

extension RepoRepository: TestDependencyKey {
  public static var testValue = Self(
    repositories: unimplemented("\(Self.self).repositories")
  )
}
