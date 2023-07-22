import Foundation

public struct GitHubUsersRequest: GitHubRequest {
  public typealias Response = [GitHubUserResponse]
  
  public var path: String {
    "users"
  }
  public var method: APIMethod {
    .get
  }
  public var queryParams: [String: String?] {
    [
      "page": "\(page)",
    ]
  }
  
  public var page: Int // starts from 1

  public init(page: Int) {
    self.page = page
  }
}
