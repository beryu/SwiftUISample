import Foundation

public struct UserEntity: Equatable {
  public var id: Int
  public var login: String
  public var avatarURL: URL

  public init(id: Int, login: String, avatarURL: URL) {
    self.id = id
    self.login = login
    self.avatarURL = avatarURL
  }
}
