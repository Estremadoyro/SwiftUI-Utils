//
//  ContentView.swift
//  DrawingPathShape
//
//  Created by Leonardo  on 18/11/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    // PathView()
    ShapesView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
  }
}
