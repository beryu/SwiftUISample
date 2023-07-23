import API
import Dependencies
import Entities

public protocol RepoRepository {
  func repositories(login: String, page: Int) async throws -> [RepoEntity]
}
