import API
import Dependencies
import Entities

public enum UserRepositoryKey: DependencyKey {
  public static var liveValue: UserRepository = UserRepositoryImpl()
}

extension DependencyValues {
  public var userRepository: UserRepository {
    get { self[UserRepositoryKey.self] }
    set { self[UserRepositoryKey.self] = newValue }
  }
}

struct UserRepositoryImpl: UserRepository {
  @Dependency(\.apiClient) var apiClient

  func users(since: Int?) async throws -> [UserEntity] {
    let response = try await apiClient.request(apiRequest: GitHubUsersRequest(since: since))
    return response.map({ UserEntity.init(user: $0) })
  }

  func searchUsers(query: String, page: Int) async throws -> [UserEntity] {
    let response = try await apiClient.request(apiRequest: GitHubSearchUsersRequest(query: query, page: page))
    if response.incompleteResults {
      throw UserRepositoryError.incomplete
    }
    return response.items.map({ UserEntity.init(user: $0) })
  }
}
