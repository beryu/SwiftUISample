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
      }
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
    return [
      UserEntity(
        id: 1,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
      UserEntity(
        id: 2,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
      UserEntity(
        id: 3,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
      UserEntity(
        id: 4,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
      UserEntity(
        id: 5,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
      UserEntity(
        id: 6,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
      UserEntity(
        id: 7,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
      UserEntity(
        id: 8,
        login: "beryu",
        avatarURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
      ),
    ]
  }

  func searchUsers(query: String, page: Int) async throws -> [UserEntity] {
    unimplemented()
  }
}

#endif
