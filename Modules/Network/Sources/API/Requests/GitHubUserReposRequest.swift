import Foundation

public struct GitHubUserReposRequest: GitHubRequest {
  public typealias Response = [GitHubUserRepoResponse]
  
  public var path: String {
    "users/\(user)/repos"
  }
  public var method: APIMethod {
    .get
  }
  public var queryParams: [String: String?] {
    [
      "page": "\(page)",
    ]
  }

  public var user: String
  public var page: Int // starts from 1

  public init(user: String, page: Int) {
    self.user = user
    self.page = page
  }
}
