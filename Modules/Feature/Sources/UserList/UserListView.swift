import Components
import Dependencies
import Entities
import UserRepository
import SharedExtension
import SharedResource
import SwiftUI

public struct UserListView: View {
  @ObservedObject private var viewModel: UserListViewModel

  public init() {
    viewModel = UserListViewModel()
  }

  public var body: some View {
    Group {
      if viewModel.users.isEmpty && viewModel.isLoading {
        VStack(spacing: 8) {
          ProgressView()
          Text(L10n.Common.Loading.text)
            .bodyText()
        }
      } else {
        List {
          ForEach(0 ..< viewModel.users.count, id: \.self) { index in
            let user = viewModel.users[index]
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
        .listStyle(PlainListStyle())
      }
    }
    .alert(isPresented: $viewModel.isErrorAlertShown) {
      Alert(
        title: Text(L10n.UserList.LoadError.Alert.title),
        message: Text(L10n.UserList.LoadError.Alert.message)
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

struct UserListView_Previews: PreviewProvider {
  static var previews: some View {
    withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      UserListView()
    }
  }
}

struct UserRepositoryMock: UserRepository {
  func users(since: Int?) async throws -> [UserEntity] {
    if since ?? 0 >= 150 {
      throw UserRepositoryError.incomplete
    }
    if since ?? 0 >= 100 {
      return [] // NOTE: Comment out when test error dialog
    }
    return (0 ..< 20).map { index in
      let id = index + (since ?? 0)
      return UserEntity(
        id: id,
        login: "beryu \(id)",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      )
    }
  }

  func searchUsers(query: String, page: Int) async throws -> [UserEntity] {
    unimplemented()
  }
}

#endif
