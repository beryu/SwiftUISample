import SharedExtension
import SwiftUI

public struct UserRowView: View {
  private var name: String
  private var imageURL: URL

  public init(name: String, imageURL: URL) {
    self.name = name
    self.imageURL = imageURL
  }

  public var body: some View {
    HStack {
      AsyncImage(
        url: imageURL,
        content: { image in
          image
            .resizable()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
        },
        placeholder: {
          ProgressView()
            .frame(width: 60, height: 60)
        }
      )
      Text(name)
        .cellTitleText()
      Spacer()
    }
  }
}

#if DEBUG

struct UserRowView_Previews: PreviewProvider {
  static var previews: some View {
    UserRowView(
      name: "beryu",
      imageURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
    )
  }
}

#endif
