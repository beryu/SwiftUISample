import Foundation

public enum UserRepositoryError: Error {
  case incomplete
  case notFound
  case unknown
}

extension UserRepositoryError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .incomplete:
      return "UserRepositoryError.incomplete"
    case .notFound:
      return "UserRepositoryError.notFound"
    case .unknown:
      return "UserRepositoryError.unknown"
    }
  }
}
