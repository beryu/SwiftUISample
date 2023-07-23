import Foundation

public struct GitHubUserDetailResponse: Decodable {
  public var id: Int
  public var name: String
  public var login: String
  public var avatarURL: URL
  public var followers: Int
  public var following: Int

  public enum CodingKeys: String, CodingKey {
    case id
    case name
    case login
    case avatarURL = "avatarUrl"
    case followers
    case following
  }

  public init(
    id: Int,
    name: String,
    login: String,
    avatarURL: URL,
    followers: Int,
    following: Int
  ) {
    self.id = id
    self.name = name
    self.login = login
    self.avatarURL = avatarURL
    self.followers = followers
    self.following = following
  }
}
