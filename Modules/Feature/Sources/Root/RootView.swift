import SwiftUI
import UserList

public struct RootView: View {
  public init() {}
  
  public var body: some View {
    TabView {
      UserListView()
        .tabItem {
          VStack {
            Image(systemName: "list.bullet")
            Text("List")
          }
        }
      Text("Page B")
        .tabItem {
          VStack {
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
        }
    }
  }
}

#if DEBUG

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}

#endif
