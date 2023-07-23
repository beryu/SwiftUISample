import Foundation

public struct GitHubUserResponse: Decodable {
  public var id: Int
  public var login: String
  public var avatarURL: URL

  public enum CodingKeys: String, CodingKey {
    case id
    case login
    case avatarURL = "avatarUrl"
  }

  public init(id: Int, login: String, avatarURL: URL) {
    self.id = id
    self.login = login
    self.avatarURL = avatarURL
  }
}
