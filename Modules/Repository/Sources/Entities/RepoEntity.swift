import Foundation

public struct RepoEntity: Equatable {
  public var id: Int
  public var name: String
  public var fullName: String
  public var stargazersCount: Int
  public var description: String?
  public var language: String?
  public var isFork: Bool

  public init(
    id: Int,
    name: String,
    fullName: String,
    stargazersCount: Int,
    description: String? = nil,
    language: String? = nil,
    isFork: Bool
  ) {
    self.id = id
    self.name = name
    self.fullName = fullName
    self.stargazersCount = stargazersCount
    self.description = description
    self.language = language
    self.isFork = isFork
  }
}
