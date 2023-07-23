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
    do {
      let response = try await apiClient.request(apiRequest: GitHubUsersRequest(since: since))
      return response.map({ UserEntity(user: $0) })
    } catch {
      throw convert(error: error)
    }
  }

  func userDetail(login: String) async throws -> UserDetailEntity {
    do {
      let response = try await apiClient.request(apiRequest: GitHubUserDetailRequest(login: login))
      return UserDetailEntity(user: response)
    } catch {
      throw convert(error: error)
    }
  }

  func searchUsers(query: String, page: Int) async throws -> [UserEntity] {
    do {
      let response = try await apiClient.request(apiRequest: GitHubSearchUsersRequest(query: query, page: page))
      if response.incompleteResults {
        throw UserRepositoryError.incomplete
      }
      return response.items.map({ UserEntity(user: $0) })
    } catch {
      throw convert(error: error)
    }
  }

  private func convert(error: Error) -> UserRepositoryError {
    guard let error = error as? APIError else {
      return UserRepositoryError.unknown
    }
    switch error {
    case .failureWithStatusCode(let code) where code == 404:
      return UserRepositoryError.notFound
    case .badURL, .failureWithStatusCode, .responseParseError, .unknown:
      return UserRepositoryError.unknown
    }
  }
}
