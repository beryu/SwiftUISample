import Foundation

final class URLProtocolMock: URLProtocol {

  struct Response {
    let statusCode: Int
    let data: Data
  }

  static var responseDict: [URL: Response] = [:]

  override class func canInit(with request: URLRequest) -> Bool {
    true
  }

  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }

  override func startLoading() {
    guard let url = request.url, let response = Self.responseDict[url] else {
      return
    }
    let urlResponse = HTTPURLResponse(
      url: url,
      statusCode: response.statusCode,
      httpVersion: "HTTP/2",
      headerFields: nil
    )
    client?.urlProtocol(self, didReceive: urlResponse!, cacheStoragePolicy: .notAllowed)
    client?.urlProtocol(self, didLoad: response.data)

    client?.urlProtocolDidFinishLoading(self)
  }

  override func stopLoading() {
    // Do nothing
  }
}

