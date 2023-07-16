import Foundation

public enum APIError: Error {
  case failureWithStatusCode(Int)
  case responseParseError(Error)
  case unknown
}
