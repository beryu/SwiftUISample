import Foundation

public struct UserDetailEntity: Equatable {
  public var id: Int
  public var name: String
  public var login: String
  public var avatarURL: URL
  public var followers: Int
  public var following: Int
  
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
