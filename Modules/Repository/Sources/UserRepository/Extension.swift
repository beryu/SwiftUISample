import API
import Entities

extension UserEntity {
  init(user: GitHubUserResponse) {
    self.init(id: user.id, login: user.login, avatarURL: user.avatarURL)
  }
}

extension UserDetailEntity {
  init(user: GitHubUserDetailResponse) {
    self.init(
      id: user.id,
      name: user.name,
      login: user.login,
      avatarURL: user.avatarURL,
      followers: user.followers,
      following: user.following
    )
  }
}
