import Components
import SwiftUI

public struct WebView: View {
  private var url: URL

  public init(url: URL) {
    self.url = url
  }

  public var body: some View {
    SafariView(url: url)
      .edgesIgnoringSafeArea(.all)
  }
}

#if DEBUG

struct WebView_Previews: PreviewProvider {
  static var previews: some View {
    WebView(url: URL(string: "https://www.google.com")!)
  }
}

#endif
