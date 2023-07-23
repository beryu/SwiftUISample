import Combine
import Dependencies
import Entities
import UserRepository

@MainActor
final class SearchUserViewModel: ObservableObject {
  @Published var isErrorAlertShown: Bool = false
  @Published var inputText: String = ""
  @Published private(set) var query: String = ""
  @Published private(set) var users: [UserEntity] = []
  @Published private(set) var isLoading: Bool = false
  @Published private(set) var isFinished: Bool = false

  @Dependency(\.userRepository) private var userRepository

  private var currentPage: Int = 1

  func load(page: Int) async {
    isLoading = true
    do {
      let users = try await userRepository.searchUsers(query: query, page: page)
      if page == 1 {
        self.users = []
      }
      self.users.append(
        contentsOf: users
          .filter({ !self.users.contains($0) })
      )
      currentPage = page
      isLoading = false
      isFinished = users.isEmpty
      isErrorAlertShown = false
    } catch {
      isLoading = false
      isErrorAlertShown = true
    }
  }

  func search(query: String) async {
    guard self.query != query else {
      return
    }
    self.query = query
    users = []
    isFinished = false
    isLoading = false
    guard !query.isEmpty else {
      return
    }
    await load(page: 1)
  }

  func loadNextPageIfNeeded() async {
    guard !isLoading, !isFinished else {
      return
    }
    await load(page: currentPage + 1)
  }

  func refresh() async {
    isFinished = false
    isLoading = false
    await load(page: 1)
  }
}
