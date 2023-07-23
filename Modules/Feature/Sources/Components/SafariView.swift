import SwiftUI
import SafariServices

public struct SafariView: UIViewControllerRepresentable {
  private var url: URL

  public init(url: URL) {
    self.url = url
  }

  public func makeUIViewController(context: Context) -> some UIViewController {
    return SFSafariViewController(url: url)
  }

  public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}
