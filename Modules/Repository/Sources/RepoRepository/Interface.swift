import API
import Dependencies
import Entities

public protocol RepoRepository {
  func repositories(user: String, page: Int) async throws -> [RepoEntity]
}
