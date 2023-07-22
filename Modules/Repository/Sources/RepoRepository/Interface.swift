import API
import Dependencies
import Entities

public struct RepoRepository {
  public var repositories: (_ user: String, _ page: Int) async throws -> [RepoEntity]
}

public extension DependencyValues {
  var repoRepository: RepoRepository {
    get { self[RepoRepository.self] }
    set { self[RepoRepository.self] = newValue }
  }
}
