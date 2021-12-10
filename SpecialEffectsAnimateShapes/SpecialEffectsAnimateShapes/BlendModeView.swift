//
//  BlendModeView.swift
//  SpecialEffectsAnimateShapes
//
//  Created by Leonardo  on 22/11/21.
//

import SwiftUI

struct ImageBlended: View {
  var body: some View {
    Image("senku")
      // .fill(Color.red)
      /// # Multiply will `multiply View's RGB pixels 0-1`
      /// # Highest result will be `1x1`
      // .blendMode(.multiply)
      /// # It also has it's own modifier
      .colorMultiply(.red)
  }
}

/// # `Blending modes`
/// # `.multiply` -> Multiplies each RGBA pixel from the view on top/bottom (`darker`)
/// # `.screen`   -> Multiplies each RGBA pixel but then `inverts` the colors (`brighter`)
struct CirclesBlendedView: View {
  @State private var amount = 0.0
  var body: some View {
    /// # `.multiply` will result in all circles `turning black` as the BG is `black (RGBA 0)`
    /// # `.red, .green, .blue` are Apple's `custom` colors
    /// # To get the 100% colors use `Color(red: 1, gree: 0, blue: 0)` (Red)
    VStack {
      ZStack {
        /// # Red
        Circle()
          .fill(.red)
          .frame(width: 200 * self.amount)
          .offset(x: -50, y: -80)
          .blendMode(.screen)
        /// # Green
        Circle()
          .fill(.green)
          .frame(width: 200 * self.amount)
          .offset(x: 50, y: -80)
          .blendMode(.screen)
        /// # Blue
        Circle()
          .fill(.blue)
          .frame(width: 200 * self.amount)
          .blendMode(.screen)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.black)
      .ignoresSafeArea()
      Slider(value: $amount)
        .padding(.horizontal)
    }
  }
}

struct BlendModeView: View {
  var body: some View {
    // CirclesBlendedView()
    BlurSaturatedView()
  }
}

struct BlurSaturatedView: View {
  @State private var amount = 0.0
  var body: some View {
    VStack {
      Image("senku")
        .resizable()
        .scaledToFit()
        /// # Determines the `intensitiy` of the View's colors
        .saturation(self.amount)
        /// # Blurs the image
        .blur(radius: (1 - self.amount) * 20)

      Slider(value: $amount)
    }
  }
}
