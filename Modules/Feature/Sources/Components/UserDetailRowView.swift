import SharedExtension
import SharedResource
import SwiftUI

public struct UserDetailRowView: View {
  private var name: String
  private var fullName: String
  private var followers: Int
  private var following: Int
  private var imageURL: URL

  public init(
    name: String,
    fullName: String,
    followers: Int,
    following: Int,
    imageURL: URL
  ) {
    self.name = name
    self.fullName = fullName
    self.followers = followers
    self.following = following
    self.imageURL = imageURL
  }

  public var body: some View {
    HStack(spacing: 16) {
      AsyncImage(
        url: imageURL,
        content: { image in
          image
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
        },
        placeholder: {
          ProgressView()
            .frame(width: 100, height: 100)
        }
      )
      VStack(alignment: .leading, spacing: 4) {
        Text(fullName)
          .pageTitleText()
        Text(name)
          .pageSubtitleText()
        Spacer()
          .frame(height: 4)
        HStack(spacing: 4) {
          Text("\(followers)")
            .bodyBoldText()
          if followers == 1 {
            Text(L10n.Common.Follower.Text.single)
              .bodyText()
          } else {
            Text(L10n.Common.Follower.Text.multi)
              .bodyText()
          }
          Spacer()
            .frame(width: 4)
          Text("\(following)")
            .bodyBoldText()
          Text(L10n.Common.Following.text)
            .bodyText()
        }
      }
      Spacer()
    }
  }
}

#if DEBUG

struct UserDetailRowView_Previews: PreviewProvider {
  static var previews: some View {
    UserDetailRowView(
      name: "beryu",
      fullName: "Ryuta Kibe",
      followers: 45,
      following: 34,
      imageURL: URL(string: "https://avatars.githubusercontent.com/u/202968?v=4")!
    )
  }
}

#endif
