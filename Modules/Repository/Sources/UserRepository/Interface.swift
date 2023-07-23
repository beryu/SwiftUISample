import API
import Dependencies
import Entities

public protocol UserRepository {
  func searchUsers(query: String, page: Int) async throws -> [UserEntity]
}
