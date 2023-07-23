import Foundation

public struct GitHubSearchUsersResponse: Decodable {
  public var items: [GitHubUserResponse]
  public var incompleteResults: Bool

  public init(items: [GitHubUserResponse], incompleteResults: Bool) {
    self.items = items
    self.incompleteResults = incompleteResults
  }
}
