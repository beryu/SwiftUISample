import API
import Dependencies
import Entities

extension UserRepository: DependencyKey {
  public static var liveValue: Self = {
    @Dependency(\.apiClient) var apiClient

    return Self(
      searchUsers: { query, page -> [UserEntity] in
        let response = try await apiClient.request(API.GitHubSearchUsersRequest(query: query, page: page))
        if response.incompleteResults {
          throw UserRepositoryError.incomplete
        }
        return response.items.map({ UserEntity.init(user: $0) })
      }
    )
  }()
}
