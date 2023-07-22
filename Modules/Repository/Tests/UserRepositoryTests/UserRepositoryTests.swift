import API
import Dependencies
import Foundation
import XCTest
@testable import UserRepository

final class UserRepositoryTests: XCTestCase {
  func testSearchUsers() async throws {
    let userRepository: UserRepository = withDependencies({
      $0.apiClient.request = { _ -> (Data, URLResponse) in
        return mockResponse(value: .gitHubSearchUsersSuccessJSON, statusCode: 200)
      }
    }, operation: {
      UserRepository.liveValue
    })
    let users = try await userRepository.searchUsers("beryu", 1)
    XCTAssertEqual(users.count, 5)
    XCTAssertEqual(users.first!.login, "beryu")
  }
}

extension String {
  static fileprivate var gitHubSearchUsersSuccessJSON: String =
    """
{
    "total_count": 5,
    "incomplete_results": false,
    "items": [
        {
            "login": "beryu",
            "id": 202968,
            "node_id": "MDQ6VXNlcjIwMjk2OA==",
            "avatar_url": "https://avatars.githubusercontent.com/u/202968?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/beryu",
            "html_url": "https://github.com/beryu",
            "followers_url": "https://api.github.com/users/beryu/followers",
            "following_url": "https://api.github.com/users/beryu/following{/other_user}",
            "gists_url": "https://api.github.com/users/beryu/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/beryu/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/beryu/subscriptions",
            "organizations_url": "https://api.github.com/users/beryu/orgs",
            "repos_url": "https://api.github.com/users/beryu/repos",
            "events_url": "https://api.github.com/users/beryu/events{/privacy}",
            "received_events_url": "https://api.github.com/users/beryu/received_events",
            "type": "User",
            "site_admin": false,
            "score": 1.0
        },
        {
            "login": "beryu77",
            "id": 64938573,
            "node_id": "MDQ6VXNlcjY0OTM4NTcz",
            "avatar_url": "https://avatars.githubusercontent.com/u/64938573?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/beryu77",
            "html_url": "https://github.com/beryu77",
            "followers_url": "https://api.github.com/users/beryu77/followers",
            "following_url": "https://api.github.com/users/beryu77/following{/other_user}",
            "gists_url": "https://api.github.com/users/beryu77/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/beryu77/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/beryu77/subscriptions",
            "organizations_url": "https://api.github.com/users/beryu77/orgs",
            "repos_url": "https://api.github.com/users/beryu77/repos",
            "events_url": "https://api.github.com/users/beryu77/events{/privacy}",
            "received_events_url": "https://api.github.com/users/beryu77/received_events",
            "type": "User",
            "site_admin": false,
            "score": 1.0
        },
        {
            "login": "Beryukova",
            "id": 121339505,
            "node_id": "U_kgDOBzt-cQ",
            "avatar_url": "https://avatars.githubusercontent.com/u/121339505?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/Beryukova",
            "html_url": "https://github.com/Beryukova",
            "followers_url": "https://api.github.com/users/Beryukova/followers",
            "following_url": "https://api.github.com/users/Beryukova/following{/other_user}",
            "gists_url": "https://api.github.com/users/Beryukova/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/Beryukova/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/Beryukova/subscriptions",
            "organizations_url": "https://api.github.com/users/Beryukova/orgs",
            "repos_url": "https://api.github.com/users/Beryukova/repos",
            "events_url": "https://api.github.com/users/Beryukova/events{/privacy}",
            "received_events_url": "https://api.github.com/users/Beryukova/received_events",
            "type": "User",
            "site_admin": false,
            "score": 1.0
        },
        {
            "login": "beryu98",
            "id": 33437733,
            "node_id": "MDQ6VXNlcjMzNDM3NzMz",
            "avatar_url": "https://avatars.githubusercontent.com/u/33437733?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/beryu98",
            "html_url": "https://github.com/beryu98",
            "followers_url": "https://api.github.com/users/beryu98/followers",
            "following_url": "https://api.github.com/users/beryu98/following{/other_user}",
            "gists_url": "https://api.github.com/users/beryu98/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/beryu98/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/beryu98/subscriptions",
            "organizations_url": "https://api.github.com/users/beryu98/orgs",
            "repos_url": "https://api.github.com/users/beryu98/repos",
            "events_url": "https://api.github.com/users/beryu98/events{/privacy}",
            "received_events_url": "https://api.github.com/users/beryu98/received_events",
            "type": "User",
            "site_admin": false,
            "score": 1.0
        },
        {
            "login": "Nerfarino",
            "id": 39738863,
            "node_id": "MDQ6VXNlcjM5NzM4ODYz",
            "avatar_url": "https://avatars.githubusercontent.com/u/39738863?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/Nerfarino",
            "html_url": "https://github.com/Nerfarino",
            "followers_url": "https://api.github.com/users/Nerfarino/followers",
            "following_url": "https://api.github.com/users/Nerfarino/following{/other_user}",
            "gists_url": "https://api.github.com/users/Nerfarino/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/Nerfarino/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/Nerfarino/subscriptions",
            "organizations_url": "https://api.github.com/users/Nerfarino/orgs",
            "repos_url": "https://api.github.com/users/Nerfarino/repos",
            "events_url": "https://api.github.com/users/Nerfarino/events{/privacy}",
            "received_events_url": "https://api.github.com/users/Nerfarino/received_events",
            "type": "User",
            "site_admin": false,
            "score": 1.0
        }
    ]
}
"""
}
