import Dependencies
import Foundation
import XCTest
@testable import API

// NOTE: This file is not for unit test.
//       It's just for integration test with GitHub API.
final class APIClientTests: XCTestCase {
  @Dependency(\.apiClient) var apiClient
  
//  func testGitHubUsersRequest() async throws {
//    let apiClient: APIClient = withDependencies({ _ in }, operation: {
//      .live(urlSession: .shared)
//    })
//    let searchRequest = GitHubUsersRequest(page: 1)
//    do {
//      let response = try await apiClient.request(searchRequest)
//      XCTAssertTrue(response.count > 0)
//      XCTAssertTrue(response.first!.id > 0)
//      XCTAssertEqual(response.first!.login, "mojombo")
//    } catch {
//      XCTFail("Unexpected error: " + error.localizedDescription)
//    }
//  }

//  func testGitHubSearchUsersRequest() async throws {
//    let searchRequest = GitHubSearchUsersRequest(query: "beryu", page: 1)
//    do {
//      let response = try await apiClient.request(apiRequest: searchRequest)
//      XCTAssertTrue(response.items.count > 0)
//      XCTAssertTrue(response.items.first!.id > 0)
//      XCTAssertEqual(response.items.first!.login, "beryu")
//      XCTAssertFalse(response.incompleteResults)
//    } catch {
//      XCTFail("Unexpected error: " + error.localizedDescription)
//    }
//  }

//  func testGitHubUserReposRequest() async throws {
//    let searchRequest = GitHubUserReposRequest(user: "beryu", page: 1)
//    do {
//      let response = try await apiClient.request(apiRequest: searchRequest)
//      XCTAssertTrue(response.count > 0)
//      XCTAssertTrue(response.first!.id > 0)
//      XCTAssertEqual(response.first!.name, "APIKit")
//      XCTAssertEqual(response.first!.description, "Type-safe networking abstraction layer that associates request type with response type.")
//      XCTAssertEqual(response.first!.language, "Swift")
//    } catch {
//      XCTFail("Unexpected error: " + error.localizedDescription)
//    }
//  }
}
