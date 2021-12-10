//
//  NavigationLinkView.swift
//  GeometryReaderScrollViewNavigationLink
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct ChapterView: View {
  var text: String

  var body: some View {
    Text(self.text)
  }

  init(text: String) {
    print("Loading: \(text)")
    self.text = text
  }
}

struct NavigationLinkView: View {
  var body: some View {
    NavigationView {
      /// # List is LAZY by default
      List(1 ..< 219) { chapter in
        NavigationLink {
          Text("Senkuuu")
        } label: {
          ChapterView(text: "Chapter: \(chapter)")
        }
      }
      .navigationTitle("Dr. Stone")
    }
  }
}
