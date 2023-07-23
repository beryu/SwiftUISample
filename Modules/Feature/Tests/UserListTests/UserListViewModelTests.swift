import Combine
import Dependencies
import XCTest
@testable import UserList

@MainActor
final class UserListViewModelTests: XCTestCase {
  var viewModel: UserListViewModel!

  func testInitialValues() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      UserListViewModel()
    }

    // test initial values
    XCTAssertTrue(viewModel.users.isEmpty)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertFalse(viewModel.isFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }

  func testLoad_firstPage() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      UserListViewModel()
    }

    await viewModel.load(since: nil)

    // loaded data is applied
    XCTAssertEqual(viewModel.users.count, 20)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertFalse(viewModel.isFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }

  func testLoad_fail() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      UserListViewModel()
    }

    await viewModel.load(since: nil)
    await viewModel.load(since: 150)

    // loaded data is applied, and error is shown
    XCTAssertEqual(viewModel.users.count, 20)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertFalse(viewModel.isFinished)
    XCTAssertTrue(viewModel.isErrorAlertShown)
  }

  func testLoad_finish() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      UserListViewModel()
    }

    await viewModel.load(since: nil)
    await viewModel.load(since: 100)

    // loaded data is applied, and treat as finished
    XCTAssertEqual(viewModel.users.count, 20)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertTrue(viewModel.isFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }
}
