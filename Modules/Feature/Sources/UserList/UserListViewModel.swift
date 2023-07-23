import Combine
import Dependencies
import Entities
import UserRepository

@MainActor
final class UserListViewModel: ObservableObject {
  @Published var isErrorAlertShown: Bool = false
  @Published private(set) var users: [UserEntity] = []
  @Published private(set) var isLoading: Bool = false
  @Published private(set) var isFinished: Bool = false

  @Dependency(\.userRepository) private var userRepository

  func load(since: Int?) async {
    isLoading = true
    do {
      let users = try await userRepository.users(since: since)
      if since == nil {
        self.users = []
      }
      self.users.append(
        contentsOf: users
          .filter({ !self.users.contains($0) })
      )
      isLoading = false
      isFinished = users.isEmpty
      isErrorAlertShown = false
    } catch {
      isLoading = false
      isErrorAlertShown = true
    }
  }

  func initializeIfNeeded() async {
    guard users.isEmpty else {
      return
    }
    await load(since: nil)
  }

  func loadNextPageIfNeeded() async {
    guard !isLoading, !isFinished else {
      return
    }
    await load(since: users.last?.id)
  }

  func refresh() async {
    isFinished = false
    isLoading = false
    await load(since: nil)
  }
}
