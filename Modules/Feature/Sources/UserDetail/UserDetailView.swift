import Components
import Dependencies
import Entities
import RepoRepository
import UserRepository
import SharedExtension
import SharedResource
import SwiftUI
import WebView

public struct UserDetailView: View {
  @ObservedObject private var viewModel: UserDetailViewModel

  public init(login: String) {
    viewModel = UserDetailViewModel(login: login)
  }

  public var body: some View {
    Group {
      List {
        if let user = viewModel.user {
          UserDetailRowView(
            name: user.login,
            fullName: user.name,
            followers: user.followers,
            following: user.following,
            imageURL: user.avatarURL
          )
        } else {
          HStack {
            Spacer()
            ProgressView()
              .frame(height: 108)
            Spacer()
          }
        }
        if viewModel.repos.isEmpty && viewModel.isRepoListLoading {
          HStack {
            Spacer()
            VStack(spacing: 8) {
              ProgressView()
              Text(L10n.Common.Loading.text)
                .bodyText()
            }
            Spacer()
          }
        } else {
          ForEach(0 ..< viewModel.repos.count, id: \.self) { index in
            let repo = viewModel.repos[index]
            Button(action: {
              viewModel.repositoryURL = repo.htmlURL
              viewModel.isRepositoryPresented.toggle()
            }) {
              RepoRowView(
                name: repo.name,
                language: repo.language ?? "",
                stargazersCount: repo.stargazersCount,
                description: repo.description ?? ""
              )
            }
            .sheet(isPresented: $viewModel.isRepositoryPresented) {
              if let url = viewModel.repositoryURL {
                WebView(url: url)
              }
            }
            .onAppear {
              // for infinite loading
              if index > viewModel.repos.count - 10 {
                Task {
                  await viewModel.loadNextPageIfNeeded()
                }
              }
            }
          }
        }
      }
      .listStyle(PlainListStyle())
    }
    .alert(isPresented: $viewModel.isErrorAlertShown) {
      Alert(
        title: Text(L10n.UserDetail.LoadError.Alert.title),
        message: Text(L10n.UserDetail.LoadError.Alert.message)
      )
    }
    .onAppear {
      Task {
        await viewModel.initializeIfNeeded()
      }
    }
    .refreshable {
      await viewModel.refresh()
    }
  }
}

#if DEBUG

struct UserDetailView_Previews: PreviewProvider {
  static var previews: some View {
    withDependencies {
      $0.repoRepository = RepoRepositoryMock()
      $0.userRepository = UserRepositoryMock()
    } operation: {
      UserDetailView(login: "beryu")
    }
  }
}

struct UserRepositoryMock: UserRepository {
  func users(since: Int?) async throws -> [UserEntity] {
    unimplemented()
  }

  func userDetail(login: String) async throws -> UserDetailEntity {
    .init(
      id: 202968,
      name: "Ryuta Kibe",
      login: "beryu",
      avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!,
      followers: 45,
      following: 34
    )
  }

  func searchUsers(query: String, page: Int) async throws -> [UserEntity] {
    unimplemented()
  }
}

struct RepoRepositoryMock: RepoRepository {
  func repositories(login: String, page: Int) async throws -> [RepoEntity] {
    if page >= 3 {
      throw RepoRepositoryError.unknown
    }
    if page >= 2 {
      return [] // NOTE: Comment out when test error dialog
    }
    return [
      .init(
        id: 176659883,
        name: "APIKit",
        fullName: "beryu/APIKit",
        stargazersCount: 0,
        isFork: true,
        htmlURL: URL(string: "https://github.com/beryu/APIKit")!
      ),
      .init(
        id: 663242141,
        name: "SwiftUISample",
        fullName: "beryu/SwiftUISample",
        stargazersCount: 2,
        description: "for training a modern iOS architecture",
        isFork: false,
        htmlURL: URL(string: "https://github.com/beryu/SwiftUISample")!
      ),
      .init(
        id: 136936433,
        name: "SiriShortcutsSample",
        fullName: "beryu/SiriShortcutsSample",
        stargazersCount: 13,
        isFork: false,
        htmlURL: URL(string: "https://github.com/beryu/SiriShortcutsSample")!
      ),
    ]
  }
}

#endif
