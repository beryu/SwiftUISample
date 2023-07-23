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

  func repositories(login: String, page: Int) async throws -> [RepoEntity] {
    do {
      let response = try await apiClient.request(apiRequest: GitHubUserReposRequest(login: login, page: page))
      return response.map({ RepoEntity.init(repo: $0) })
    } catch {
      throw convert(error: error)
    }
  }

  private func convert(error: Error) -> RepoRepositoryError {
    return RepoRepositoryError.unknown
  }
}
