import Foundation
import XCTest
@testable import API

final class APIRequestTests: XCTestCase {
  func testURLRequest() throws {
    let sampleAPIRequest = SampleAPIRequest()
    let urlRequest = sampleAPIRequest.urlRequest()
    XCTAssertEqual(urlRequest.url!.absoluteString, "https://example.com/v1/alive")
    XCTAssertEqual(urlRequest.httpMethod, "GET")
    XCTAssertEqual(urlRequest.allHTTPHeaderFields!.count, 1)
    XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "X-DUMMY-FIELD"), "dummydummy")
  }

  func testRequest_failWith403() async throws {
    let sampleAPIRequest = SampleAPIRequest()
    let urlSessionConfiguration = URLSessionConfiguration.default
    URLProtocolMock.responseDict = [
      sampleAPIRequest.urlRequest().url!: .init(statusCode: 403, data: Data())
    ]
    urlSessionConfiguration.protocolClasses = [URLProtocolMock.self]
    let urlSession = URLSession(configuration: urlSessionConfiguration)

    do {
      _ = try await sampleAPIRequest.request(urlSession: urlSession)
      XCTFail("Error was expected, but no error.")
    } catch {
      switch (error as! APIError) {
      case .failureWithStatusCode(let statusCode):
        XCTAssertEqual(statusCode, 403)
      default:
        XCTFail("Unexpected error: " + error.localizedDescription)
      }
    }
  }

  func testRequest_failWithParseError() async throws {
    let sampleAPIRequest = SampleAPIRequest()
    let urlSessionConfiguration = URLSessionConfiguration.default
    URLProtocolMock.responseDict = [
      sampleAPIRequest.urlRequest().url!: .init(statusCode: 200, data: "{}".data(using: .utf8)!)
    ]
    urlSessionConfiguration.protocolClasses = [URLProtocolMock.self]
    let urlSession = URLSession(configuration: urlSessionConfiguration)

    do {
      _ = try await sampleAPIRequest.request(urlSession: urlSession)
      XCTFail("Error was expected, but no error.")
    } catch {
      switch (error as! APIError) {
      case .responseParseError:
        // OK
        break
      default:
        XCTFail("Unexpected error: " + error.localizedDescription)
      }
    }
  }

  func testRequest_success() async throws {
    let sampleAPIRequest = SampleAPIRequest()
    let urlSessionConfiguration = URLSessionConfiguration.default
    URLProtocolMock.responseDict = [
      sampleAPIRequest.urlRequest().url!: .init(statusCode: 200, data: """
{
  "status": "success"
}
""".data(using: .utf8)!)
    ]
    urlSessionConfiguration.protocolClasses = [URLProtocolMock.self]
    let urlSession = URLSession(configuration: urlSessionConfiguration)

    do {
      let response = try await sampleAPIRequest.request(urlSession: urlSession)
      XCTAssertEqual(response.status, "success")
    } catch {
      XCTFail("Unexpected error: " + error.localizedDescription)
    }
  }
}

private struct SampleAPIRequest: APIRequest {
  typealias Response = SampleResponse

  var baseURL: URL = URL(string: "https://example.com")!
  var path: String = "v1/alive"
  var method: APIMethod = .get
  var headerDict: [String : String] = [
    "X-DUMMY-FIELD": "dummydummy"
  ]
}

private struct SampleResponse: Decodable {
  var status: String
}
