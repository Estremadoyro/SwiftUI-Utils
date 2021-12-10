//
//  ScrollingGridView.swift
//  GeometryReaderScrollViewNavigationLink
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct ScrollingGridView: View {
  let layoutFixed = [
    GridItem(.fixed(80)),
    GridItem(.fixed(80)),
    GridItem(.fixed(80)),
  ]
  /// # Will create as many columns as possible (fit on screen) that are at least 80 points width
  let layoutAdaptive = [
    GridItem(.adaptive(minimum: 80)),
  ]

  var body: some View {
    ScrollView(.horizontal) {
      LazyHGrid(rows: layoutAdaptive) {
        ForEach(0 ..< 1000) {
          Text("Item \($0)")
        }
      }
    }
  }
}
