import API
import Entities

extension UserEntity {
  init(user: GitHubSearchUsersResponse.User) {
    self.init(id: user.id, login: user.login, avatarURL: user.avatarURL)
  }
}
