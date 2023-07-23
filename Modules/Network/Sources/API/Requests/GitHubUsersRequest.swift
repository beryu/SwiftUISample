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
    guard let since else {
      return [:]
    }
    return [
      "since": "\(since)",
    ]
  }
  
  public var since: Int? // user id

  public init(since: Int?) {
    self.since = since
  }
}
