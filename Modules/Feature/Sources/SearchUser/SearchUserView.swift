import Components
import Dependencies
import Entities
import SharedExtension
import SharedResource
import SwiftUI
import UserDetail
import UserRepository

public struct SearchUserView: View {
  @ObservedObject private var viewModel: SearchUserViewModel

  public init() {
    viewModel = SearchUserViewModel()
  }

  public var body: some View {
    NavigationView {
      List {
        Section(header: Group {
          HStack {
            Image(systemName: "magnifyingglass")
            TextField(L10n.SearchUser.SearchBar.placeholder, text: $viewModel.inputText)
              .autocapitalization(.none)
              .autocorrectionDisabled()
              .padding(.vertical, 16)
              .onSubmit {
                Task {
                  await viewModel.search(query: viewModel.inputText)
                }
              }
          }
        }) {
          if viewModel.users.isEmpty && viewModel.isLoading && !viewModel.query.isEmpty {
            HStack {
              Spacer()
              VStack(spacing: 8) {
                ProgressView()
                Text(L10n.Common.Loading.text)
                  .bodyText()
              }
              Spacer()
            }
            .listRowSeparator(.hidden)
          } else if viewModel.query.isEmpty {
            Text(L10n.SearchUser.Empty.text)
              .bodyText()
              .padding(16)
              .listRowSeparator(.hidden)
          } else {
            ForEach(0 ..< viewModel.users.count, id: \.self) { index in
              let user = viewModel.users[index]
              NavigationLink(destination: UserDetailView(login: user.login)) {
                UserRowView(name: user.login, imageURL: user.avatarURL)
                  .onAppear {
                    // for infinite loading
                    if index > viewModel.users.count - 5 {
                      Task {
                        await viewModel.loadNextPageIfNeeded()
                      }
                    }
                  }
              }
            }
          }
        }
      }
      .listStyle(PlainListStyle())
      .navigationTitle(L10n.SearchUser.Title.text)
    }
    .alert(isPresented: $viewModel.isErrorAlertShown) {
      Alert(
        title: Text(L10n.SearchUser.LoadError.Alert.title),
        message: Text(L10n.SearchUser.LoadError.Alert.message)
      )
    }
    .refreshable {
      await viewModel.refresh()
    }
    .onReceive(
      viewModel.$inputText
        .debounce(for: 5.0, scheduler: DispatchQueue.global())
    ) { query in
      Task {
        await viewModel.search(query: query)
      }
    }
  }
}

#if DEBUG

struct SearchUserViewView_Previews: PreviewProvider {
  static var previews: some View {
    withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      SearchUserView()
    }
  }
}

struct UserRepositoryMock: UserRepository {
  func users(since: Int?) async throws -> [UserEntity] {
    unimplemented()
  }

  func userDetail(login: String) async throws -> UserDetailEntity {
    unimplemented()
  }

  func searchUsers(query: String, page: Int) async throws -> [UserEntity] {
    if page >= 5 {
      throw UserRepositoryError.incomplete
    }
    if page >= 4 {
      return [] // NOTE: Comment out when test error dialog
    }
    return (0 ..< 20).map { index in
      let id = index + ((page - 1) * 20)
      return UserEntity(
        id: id,
        login: "beryu \(id)",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      )
    }
  }
}

#endif
