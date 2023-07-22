import Foundation

public struct GitHubUserRepoResponse: Decodable {
  public var id: Int
  public var name: String
  public var fullName: String
  public var stargazersCount: Int
  public var description: String?
  public var language: String?
}
