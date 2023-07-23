import API
import Entities

extension UserEntity {
  init(user: GitHubUserResponse) {
    self.init(id: user.id, login: user.login, avatarURL: user.avatarURL)
  }
}
