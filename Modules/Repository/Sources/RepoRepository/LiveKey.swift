import API
import Dependencies
import Entities

public enum RepoRepositoryKey: DependencyKey {
  public static var liveValue: RepoRepository = RepoRepositoryImpl()
}

extension DependencyValues {
  public var repoRepository: RepoRepository {
    get { self[RepoRepositoryKey.self] }
    set { self[RepoRepositoryKey.self] = newValue }
  }
}

struct RepoRepositoryImpl: RepoRepository {
  @Dependency(\.apiClient) var apiClient

  func repositories(user: String, page: Int) async throws -> [RepoEntity] {
    let response = try await apiClient.request(apiRequest: GitHubUserReposRequest(user: user, page: page))
    return response.map({ RepoEntity.init(repo: $0) })
  }
}
