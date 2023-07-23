import SharedExtension
import SharedResource
import SwiftUI

public struct RepoRowView: View {
  private var name: String
  private var language: String
  private var stargazersCount: Int
  private var description: String

  public init(name: String, language: String, stargazersCount: Int, description: String) {
    self.name = name
    self.language = language
    self.stargazersCount = stargazersCount
    self.description = description
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(name)
        .cellTitleText()
      HStack(spacing: 4) {
        if !language.isEmpty {
          Text(language)
            .bodyText()
          Spacer()
            .frame(width: 4)
        }
        Text("\(stargazersCount)")
          .bodyBoldText()
        if stargazersCount == 1 {
          Text(L10n.Common.Star.Text.single)
            .bodyText()
        } else {
          Text(L10n.Common.Star.Text.multi)
            .bodyText()
        }
      }
      if !description.isEmpty {
        Text(description)
          .bodyText()
      }
    }
    .padding(.vertical, 8)
  }
}

#if DEBUG

struct RepoRowView_Previews: PreviewProvider {
  static var previews: some View {
    List {
      RepoRowView(
        name: "SwitfUISample",
        language: "Swift",
        stargazersCount: 2,
        description: "for training a modern iOS architecture"
      )
      RepoRowView(
        name: "SwitfUISample",
        language: "Swift",
        stargazersCount: 2,
        description: "for training a modern iOS architecture"
      )
    }
  }
}

#endif
