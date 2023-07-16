import Foundation
import Constants

public protocol GitHubRequest: APIRequest {
}

public extension GitHubRequest {
  var baseURL: URL? {
    return URL(string: "https://api.github.com")
  }

  var headerDict: [String : String] {
    return [
      "Accept": "application/vnd.github+json",
      "Authorization": "Bearer \(Constants.gitHubAccessToken)",
      "X-GitHub-Api-Version": "2022-11-28",
    ]
  }
}
