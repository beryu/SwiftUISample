import API
import Dependencies
import Entities

public protocol UserRepository {
  func users(since: Int?) async throws -> [UserEntity]
  func userDetail(login: String) async throws -> UserDetailEntity
  func searchUsers(query: String, page: Int) async throws -> [UserEntity]
}
