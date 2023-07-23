import API
import Dependencies
import Foundation
import XCTest
@testable import RepoRepository

final class RepoRepositoryTests: XCTestCase {
  private var apiClient: APIClient!

  override func setUp() async throws {
    apiClient = APIClientMock(response: [
      GitHubUserReposRequest(login: "beryu", page: 1).hashValue: [
        GitHubUserRepoResponse(
          id: 1,
          name: "Name1",
          fullName: "FullName1",
          stargazersCount: 11,
          description: "This is description1",
          language: "Swift1",
          fork: false
        ),
        GitHubUserRepoResponse(
          id: 2,
          name: "Name2",
          fullName: "FullName2",
          stargazersCount: 12,
          description: "This is description2",
          language: "Swift2",
          fork: true
        )
      ]
    ])
  }

  func testRepositories() async throws {
    let repoRepository: RepoRepository = withDependencies({
      $0.apiClient = apiClient
    }, operation: {
      RepoRepositoryKey.liveValue
    })
    let repositories = try await repoRepository.repositories(login: "beryu", page: 1)
    XCTAssertEqual(repositories.count, 2)
    XCTAssertEqual(repositories.first!.name, "Name1")
    XCTAssertEqual(repositories.first!.fullName, "FullName1")
    XCTAssertEqual(repositories.first!.description, "This is description1")
    XCTAssertEqual(repositories.first!.language, "Swift1")
    XCTAssertFalse(repositories.first!.isFork)
  }
}
