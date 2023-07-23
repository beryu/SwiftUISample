import API
import Dependencies
import Foundation
import XCTest
@testable import UserRepository

final class UserRepositoryTests: XCTestCase {
  private var apiClient: APIClient!

  override func setUp() async throws {
    apiClient = APIClientMock(response: [
      GitHubUsersRequest(since: nil).hashValue: [
        GitHubUserResponse(
          id: 1,
          login: "beryu",
          avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
        ),
        GitHubUserResponse(
          id: 2,
          login: "test",
          avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202969?v=4")!
        )
      ],
      GitHubSearchUsersRequest(query: "beryu", page: 1).hashValue: GitHubSearchUsersResponse(
        items: [
          GitHubUserResponse(
            id: 1,
            login: "beryu",
            avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
          ),
          GitHubUserResponse(
            id: 2,
            login: "test",
            avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202969?v=4")!
          )
        ],
        incompleteResults: false
      )
    ])
  }

  func testUsers() async throws {
    let userRepository: UserRepository = withDependencies({
      $0.apiClient = apiClient
    }, operation: {
      UserRepositoryKey.liveValue
    })
    let users = try await userRepository.users(since: nil)
    XCTAssertEqual(users.count, 2)
    XCTAssertEqual(users.first!.login, "beryu")
    XCTAssertEqual(users.first!.avatarURL.absoluteString, "https://avatars.githubusercontent.com/u/202968?v=4")
  }

  func testSearchUsers() async throws {
    let userRepository: UserRepository = withDependencies({
      $0.apiClient = apiClient
    }, operation: {
      UserRepositoryKey.liveValue
    })
    let users = try await userRepository.searchUsers(query: "beryu", page: 1)
    XCTAssertEqual(users.count, 2)
    XCTAssertEqual(users.first!.login, "beryu")
    XCTAssertEqual(users.first!.avatarURL.absoluteString, "https://avatars.githubusercontent.com/u/202968?v=4")
  }
}
