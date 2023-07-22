import API
import Entities

extension RepoEntity {
  init(repo: GitHubUserRepoResponse) {
    self.init(
      id: repo.id,
      name: repo.name,
      fullName: repo.fullName,
      stargazersCount: repo.stargazersCount,
      description: repo.description,
      language: repo.language
    )
  }
}
