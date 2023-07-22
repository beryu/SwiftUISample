import API
import Dependencies
import Entities

public struct UserRepository {
  public var searchUsers: (_ query: String, _ page: Int) async throws -> [UserEntity]
}

public extension DependencyValues {
  var userRepository: UserRepository {
    get { self[UserRepository.self] }
    set { self[UserRepository.self] = newValue }
  }
}
