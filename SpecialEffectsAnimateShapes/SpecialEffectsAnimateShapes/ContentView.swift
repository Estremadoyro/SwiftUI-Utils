//
//  ContentView.swift
//  SpecialEffectsAnimateShapes
//
//  Created by Leonardo  on 21/11/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    // BlendModeView()
    // AnimateDataView()
    // AnimatablePairView()
    SpirographView()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .preferredColorScheme(.dark)
  }
}
