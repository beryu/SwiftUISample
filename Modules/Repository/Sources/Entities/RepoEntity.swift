import Foundation

public struct RepoEntity: Equatable {
  public var id: Int
  public var name: String
  public var fullName: String
  public var stargazersCount: Int
  public var description: String?
  public var language: String?
  public var isFork: Bool
  public var htmlURL: URL

  public init(
    id: Int,
    name: String,
    fullName: String,
    stargazersCount: Int,
    description: String? = nil,
    language: String? = nil,
    isFork: Bool,
    htmlURL: URL
  ) {
    self.id = id
    self.name = name
    self.fullName = fullName
    self.stargazersCount = stargazersCount
    self.description = description
    self.language = language
    self.isFork = isFork
    self.htmlURL = htmlURL
  }
}
