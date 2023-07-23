import Foundation

public enum RepoRepositoryError: Error {
  case unknown
}

extension RepoRepositoryError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .unknown:
      return "RepoRepositoryError.unknown"
    }
  }
}
