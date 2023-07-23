import Combine
import Dependencies
import XCTest
@testable import SearchUser

@MainActor
final class SearchUserViewModelTests: XCTestCase {
  var viewModel: SearchUserViewModel!

  func testInitialValues() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      SearchUserViewModel()
    }

    // test initial values
    XCTAssertTrue(viewModel.users.isEmpty)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertFalse(viewModel.isFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }

  func testSearch_firstPage() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      SearchUserViewModel()
    }

    await viewModel.search(query: "beryu")

    // loaded data is applied
    XCTAssertEqual(viewModel.users.count, 20)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertFalse(viewModel.isFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }

  func testSearch_fail() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      SearchUserViewModel()
    }

    await viewModel.search(query: "beryu")
    await viewModel.load(page: 5)

    // loaded data is applied, and error is shown
    XCTAssertEqual(viewModel.users.count, 20)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertFalse(viewModel.isFinished)
    XCTAssertTrue(viewModel.isErrorAlertShown)
  }

  func testSearch_finish() async {
    viewModel = withDependencies {
      $0.userRepository = UserRepositoryMock()
    } operation: {
      SearchUserViewModel()
    }

    await viewModel.search(query: "beryu")
    await viewModel.load(page: 4)

    // loaded data is applied, and treat as finished
    XCTAssertEqual(viewModel.users.count, 20)
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertTrue(viewModel.isFinished)
    XCTAssertFalse(viewModel.isErrorAlertShown)
  }
}
