import Foundation

public struct GitHubUserRepoResponse: Decodable {
  public var id: Int
  public var name: String
  public var fullName: String
  public var stargazersCount: Int
  public var description: String?
  public var language: String?

  public init(
    id: Int,
    name: String,
    fullName: String,
    stargazersCount: Int,
    description: String? = nil,
    language: String? = nil
  ) {
    self.id = id
    self.name = name
    self.fullName = fullName
    self.stargazersCount = stargazersCount
    self.description = description
    self.language = language
  }
}
