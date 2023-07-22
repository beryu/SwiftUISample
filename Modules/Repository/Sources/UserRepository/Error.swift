import Foundation

public enum UserRepositoryError: Error {
  case incomplete
}

extension UserRepositoryError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .incomplete:
      return "UserRepositoryError.incomplete"
    }
  }
}
