//
//  DrawingGroupView.swift
//  CGAffineImagePaintDrawingGroup
//
//  Created by Leonardo  on 21/11/21.
//

import SwiftUI

struct ColorCyclingCircle: View {
  /// # Number to alter the computed `hue`, from `0.0 to 1.0`
  var cycleAmount = 0.0
  /// # Number of circles
  var steps = 100

  func color(for value: Int, brightness: Double) -> Color {
    var hue = (Double(value) / Double(steps)) + cycleAmount
    /// # `Reset` the `hue` value when it reaches `0`, as it only goes from `0 red` to `1 red`
    if hue > 1 { hue -= 1 }
    return Color(hue: hue, saturation: 1, brightness: brightness)
  }

  var body: some View {
    ZStack {
      ForEach(0 ..< self.steps) { value in
        Circle()
          /// # Makes circle `smaller`
          ///  # When applied multiplie times the `circle seems with a thicker border`, `but` in fact is a `bunch of smaller circles inset on eachother`
          .inset(by: Double(value))
          /// # Gradients make the app `run under 60fps, bad performance`
          .strokeBorder(LinearGradient(gradient: Gradient(colors: [
            color(for: value, brightness: 1),
            color(for: value, brightness: 0.5)
          ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
        // .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
      }
    }
    /// # HOWEVER, calling `Metal's API .drawingGroup()` method `drastically` improves the performance
    /// # Renders the `contents` of the view in an `offscreen image` before putting it `back on the screen`
    /// # May `slow SwiftUI's drawing `, only use when `needed`
    .drawingGroup()
  }
}

/// # `drawingGroup()` put's the view together in an `image offscreen` before `displaying it`
/// # This uses `Metal's API`
/// # `Core Animation` is the one used by `default`
struct DrawingGroupView: View {
  @State private var cycleAmount = 0.0
  var body: some View {
    VStack {
      ColorCyclingCircle(cycleAmount: self.cycleAmount)
      Text("Cycle amount: \(self.cycleAmount, specifier: "%.2f")")
      Slider(value: $cycleAmount)
    }
  }
}
