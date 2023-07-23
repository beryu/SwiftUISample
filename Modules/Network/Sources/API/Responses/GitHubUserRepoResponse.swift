import Foundation

public struct GitHubUserRepoResponse: Decodable {
  public var id: Int
  public var name: String
  public var fullName: String
  public var stargazersCount: Int
  public var description: String?
  public var language: String?
  public var fork: Bool
  public var htmlURL: URL

  public enum CodingKeys: String, CodingKey {
    case id
    case name
    case fullName
    case stargazersCount
    case description
    case language
    case fork
    case htmlURL = "htmlUrl"
  }

  public init(
    id: Int,
    name: String,
    fullName: String,
    stargazersCount: Int,
    description: String? = nil,
    language: String? = nil,
    fork: Bool,
    htmlURL: URL
  ) {
    self.id = id
    self.name = name
    self.fullName = fullName
    self.stargazersCount = stargazersCount
    self.description = description
    self.language = language
    self.fork = fork
    self.htmlURL = htmlURL
  }
}
