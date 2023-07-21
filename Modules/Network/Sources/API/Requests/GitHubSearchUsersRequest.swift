import Foundation

public struct GitHubSearchUsersRequest: GitHubRequest {
  public typealias Response = GitHubSearchUsersResponse
  
  public var path: String {
    "search/users"
  }
  public var method: APIMethod {
    .get
  }
  public var queryParams: [String: String?] {
    [
      "q": query,
      "page": "\(page)",
    ]
  }
  
  public var query: String
  public var page: Int // starts from 1
  
  public init(query: String, page: Int) {
    self.query = query
    self.page = page
  }
}
