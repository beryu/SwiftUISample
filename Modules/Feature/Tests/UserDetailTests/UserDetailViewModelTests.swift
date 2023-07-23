import Combine
import Dependencies
import XCTest
@testable import UserDetail

@MainActor
final class UserDetailViewModelTests: XCTestCase {
  var viewModel: UserDetailViewModel!

  override func setUp() async throws {
    viewModel = withDependencies {
      $0.repoRepository = RepoRepositoryMock()
      $0.userRepository = UserRepositoryMock()
    } operation: {
      UserDetailViewModel(login: "beryu")
    }
  }

  func testInitialValues() async {
    XCTAssertTrue(viewModel.repos.isEmpty)
    XCTAssertFalse(viewModel.isUserDetailLoading)
    XCTAssertFalse(viewModel.isRepoListLoading)
    XCTAssertFalse(viewModel.isRepoListFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }

  func testLoad_userDetail() async {
    await viewModel.loadUserDetail()

    // loaded data is applied
    XCTAssertEqual(viewModel.user!.login, "beryu")
    XCTAssertEqual(viewModel.user!.name, "Ryuta Kibe")
    XCTAssertEqual(viewModel.user!.followers, 45)
    XCTAssertEqual(viewModel.user!.following, 34)
    XCTAssertFalse(viewModel.isUserDetailLoading)
    XCTAssertFalse(viewModel.isErrorAlertShown)

  }

  func testLoad_firstPage() async {
    await viewModel.loadRepoList(page: 1)

    // loaded data is applied
    XCTAssertEqual(viewModel.repos.count, 2)
    XCTAssertFalse(viewModel.isRepoListLoading)
    XCTAssertFalse(viewModel.isRepoListFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }

  func testLoad_fail() async {
    await viewModel.loadRepoList(page: 1)
    await viewModel.loadRepoList(page: 3)

    // loaded data is applied, and error is shown
    XCTAssertEqual(viewModel.repos.count, 2)
    XCTAssertFalse(viewModel.isRepoListLoading)
    XCTAssertFalse(viewModel.isRepoListFinished)
    XCTAssertTrue(viewModel.isErrorAlertShown)
  }

  func testLoad_finish() async {
    await viewModel.loadRepoList(page: 1)
    await viewModel.loadRepoList(page: 2)

    // loaded data is applied, and treat as finished
    XCTAssertEqual(viewModel.repos.count, 2)
    XCTAssertFalse(viewModel.isRepoListLoading)
    XCTAssertTrue(viewModel.isRepoListFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }
}
