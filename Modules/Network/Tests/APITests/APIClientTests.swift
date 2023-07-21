import Dependencies
import Foundation
import XCTest
@testable import API

// NOTE: This is not unit test.
//       It's just for integration test with GitHub API.
final class APIClientTests: XCTestCase {
//  func testRequest() async throws {
//    let apiClient: APIClient = withDependencies({ _ in }, operation: {
//      .live(urlSession: .shared)
//    })
//    let searchRequest = API.GitHubSearchUsersRequest(query: "beryu", page: 1)
//    do {
//      let response = try await apiClient.request(searchRequest)
//      XCTAssertTrue(response.items.count > 0)
//      XCTAssertTrue(response.items.first!.id > 0)
//      XCTAssertEqual(response.items.first!.login, "beryu")
//      XCTAssertFalse(response.incompleteResults)
//    } catch {
//      XCTFail("Unexpected error: " + error.localizedDescription)
//    }
//  }
}
