import Combine
import Dependencies
import Entities
import Foundation
import RepoRepository
import UserRepository

@MainActor
final class UserDetailViewModel: ObservableObject {
  @Published var isErrorAlertShown: Bool = false
  @Published var isRepositoryPresented: Bool = false
  var repositoryURL: URL?

  @Published private(set) var user: UserDetailEntity? = nil
  @Published private(set) var repos: [RepoEntity] = []
  @Published private(set) var isUserDetailLoading: Bool = false
  @Published private(set) var isRepoListLoading: Bool = false
  @Published private(set) var isRepoListFinished: Bool = false

  @Dependency(\.userRepository) private var userRepository
  @Dependency(\.repoRepository) private var repoRepository

  private var login: String
  private var currentPage: Int = 1

  public init(login: String) {
    self.login = login
  }

  func loadUserDetail() async {
    isUserDetailLoading = true
    do {
      user = try await userRepository.userDetail(login: login)
      isUserDetailLoading = false
      isErrorAlertShown = false
    } catch {
      isUserDetailLoading = false
      isErrorAlertShown = true
    }
  }

  func loadRepoList(page: Int) async {
    isRepoListLoading = true
    do {
      let repos = try await repoRepository.repositories(login: login, page: page)
      if page == 1 {
        self.repos = []
      }
      self.repos.append(
        contentsOf: repos
          .filter({ !$0.isFork })
          .filter({ !self.repos.contains($0) })
      )
      currentPage = page
      isRepoListLoading = false
      isRepoListFinished = repos.isEmpty
      isErrorAlertShown = false
    } catch {
      isRepoListLoading = false
      isErrorAlertShown = true
    }
  }

  func initializeIfNeeded() async {
    guard user == nil, repos.isEmpty else {
      return
    }
    await loadRepoList(page: 1)
    await loadUserDetail()
  }

  func loadNextPageIfNeeded() async {
    guard !isRepoListLoading, !isRepoListFinished else {
      return
    }
    await loadRepoList(page: currentPage + 1)
  }

  func refresh() async {
    isUserDetailLoading = false
    isRepoListFinished = false
    isRepoListLoading = false
    await loadRepoList(page: 1)
    await loadUserDetail()
  }
}
