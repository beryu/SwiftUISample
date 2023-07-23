import SearchUser
import SwiftUI
import UserList

public struct RootView: View {
  @State private var selectedTab: Tab = .list

  public init() {}
  
  public var body: some View {
    TabView(selection: $selectedTab) {
      UserListView()
        .tabItem {
          VStack {
            Image(systemName: "list.bullet")
            Text("List")
          }
        }
        .tag(Tab.list)
      SearchUserView()
        .tabItem {
          VStack {
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
        }
        .tag(Tab.search)
    }
  }
}

private enum Tab: String {
  case list
  case search
}

#if DEBUG

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}

#endif
