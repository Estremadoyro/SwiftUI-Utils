//
//  ContentView.swift
//  Arrow
//
//  Created by Leonardo  on 23/11/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    // ArrowView()
    ColorCyclingView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
  }
}
