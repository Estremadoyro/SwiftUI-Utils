//
//  ColorCycling.swift
//  Arrow
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct ColorCyclingRectangle: View {
  var colorCycle: Double
  var squares: Int = 100

  func color(for squareNumber: Int, brightness: Double) -> Color {
    var hue = (Double(squareNumber) / Double(squares)) + colorCycle
    if hue > 1 { hue -= 1 }
    return Color(hue: hue, saturation: 1, brightness: 1)
  }

  var body: some View {
    ZStack {
      ForEach(0 ..< self.squares) { value in
        Rectangle()
          /// # This generates an `InsettableShape`
          .inset(by: Double(value))
          .strokeBorder(
            LinearGradient(gradient: Gradient(colors: [
              self.color(for: value, brightness: 1),
              self.color(for: value, brightness: 0.5)
            ]), startPoint: .top, endPoint: .bottom),
            lineWidth: 2)
      }
    }
    /// # `Metal`
    .drawingGroup()
  }
}

struct ColorCyclingView: View {
  @State private var colorCycle = 0.0
  @State private var nSquares = 100.0
  var body: some View {
    VStack {
      ColorCyclingRectangle(colorCycle: self.colorCycle, squares: Int(self.nSquares))
        .frame(width: 400, height: 400)
      Text("Squares: \(self.nSquares, specifier: "%.0f")")
      Slider(value: $nSquares, in: 1 ... 100)
      Slider(value: $colorCycle, in: 0 ... 1)
    }
    .padding(.horizontal)
  }
}
