import Foundation

public struct GitHubSearchUsersResponse: Decodable {
  public var items: [User]
  public var incompleteResults: Bool

  public struct User: Decodable {
    public var id: Int
    public var login: String
    public var avatarURL: URL

    public enum CodingKeys: String, CodingKey {
      case id
      case login
      case avatarURL = "avatarUrl"
    }
  }
}
