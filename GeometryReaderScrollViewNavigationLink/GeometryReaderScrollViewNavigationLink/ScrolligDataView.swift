//
//  ScrollView.swift
//  GeometryReaderScrollViewNavigationLink
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct CustomText: View {
  var inputText: String
  var body: some View {
    Text(self.inputText)
  }

  init(_ text: String) {
    print("Loading: \(text)")
    self.inputText = text
  }
}

struct ScrollingDataView: View {
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      /// # VStack will load ALL the views at once
      /// # LazyVStack will load only what is SEEN on screen
      /// # Will only work with width: .infinity and height: .inifinity
      LazyVStack(spacing: 10) {
        ForEach(0 ..< 100) {
          CustomText("Item \($0)")
            .font(.title)
        }
      }
      /// # Makes it so you can scroll from any part of the screen
      .frame(maxWidth: .infinity)
    }
  }
}
