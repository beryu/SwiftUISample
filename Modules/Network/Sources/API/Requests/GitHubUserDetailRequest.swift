import Foundation

public struct GitHubUserDetailRequest: GitHubRequest {
  public typealias Response = GitHubUserDetailResponse
  
  public var path: String {
    "users/\(login)"
  }
  public var method: APIMethod {
    .get
  }
  public var queryParams: [String: String?] {
    return [:]
  }
  
  public var login: String

  public init(login: String) {
    self.login = login
  }
}
