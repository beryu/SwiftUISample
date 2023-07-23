import Foundation

public struct GitHubUserReposRequest: GitHubRequest {
  public typealias Response = [GitHubUserRepoResponse]
  
  public var path: String {
    "users/\(login)/repos"
  }
  public var method: APIMethod {
    .get
  }
  public var queryParams: [String: String?] {
    [
      "page": "\(page)",
      "sort": "updated"
    ]
  }

  public var login: String
  public var page: Int // starts from 1

  public init(login: String, page: Int) {
    self.login = login
    self.page = page
  }
}
