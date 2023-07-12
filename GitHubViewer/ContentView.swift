//
//  ContentView.swift
//  GitHubViewer
//
//  Created by Ryuta Kibe on 2023/07/07.
//

import SwiftUI
import SharedResource

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
          Text(L10n.Common.Title.text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
