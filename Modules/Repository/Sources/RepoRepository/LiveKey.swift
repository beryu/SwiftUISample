import API
import Dependencies
import Entities

extension RepoRepository: DependencyKey {
  public static var liveValue: Self = {
    @Dependency(\.apiClient) var apiClient

    return Self(
      repositories: { user, page -> [RepoEntity] in
        let response = try await apiClient.request(GitHubUserReposRequest(user: user, page: page))
        return response.map({ RepoEntity.init(repo: $0) })
      }
    )
  }()
}
