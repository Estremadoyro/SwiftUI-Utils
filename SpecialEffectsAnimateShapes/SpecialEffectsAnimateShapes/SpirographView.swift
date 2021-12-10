//
//  Spirograph.swift
//  SpecialEffectsAnimateShapes
//
//  Created by Leonardo  on 23/11/21.
//

import SwiftUI

struct Spirograph: Shape {
  let innerRadius: Int
  let outerRadius: Int
  let distance: Int
  let amount: Double
  /// # `GCD` (Gratest Common Divisor) of `innerRadius` and `outerRadius`
  func gcd(_ a: Int, _ b: Int) -> Int {
    var a = a
    var b = b
    /// # `Euclid's Algorithim`
    while b != 0 {
      let temp = b
      b = a % b
      a = temp
    }
    return a
  }

  func path(in rect: CGRect) -> Path {
    var path = Path()
    /// # When drawing is better to work with `Doubles`
    let divisor = Double(gcd(self.innerRadius, self.outerRadius))
    let innerRadius = Double(self.innerRadius)
    let outerRadius = Double(self.outerRadius)
    let distance = Double(self.distance)
    let difference = innerRadius - outerRadius
    let endPoint = ceil(2 * Double.pi * outerRadius / divisor) * self.amount

    for theta in stride(from: 0, to: endPoint, by: 0.01) {
      var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
      var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

      /// # Center the `Spirograph` in the middle
      x += rect.width / 2
      y += rect.height / 2
      /// # For the `first instance` assign the position
      if theta == 0 {
        path.move(to: CGPoint(x: x, y: y))
      } else {
        /// # If not then `draw the line` from the `.move initial position`
        path.addLine(to: CGPoint(x: x, y: y))
      }
    }
    return path
  }
}

struct SpirographView: View {
  @State private var innerRadius: Double = 125.0
  @State private var outerRadius: Double = 75.0
  @State private var distance: Double = 25.0
  @State private var amount: Double = 1.0
  @State private var hue: Double = 0.6
  var body: some View {
    VStack {
      Spacer()
      Spirograph(innerRadius: Int(self.innerRadius), outerRadius: Int(self.outerRadius), distance: Int(self.distance), amount: self.amount)
        .stroke(Color(hue: self.hue, saturation: 1, brightness: 1))
        .frame(width: 300, height: 300)
      Spacer()
      /// # To prever reaching the `11 View limit`
      Group {
        Text("Inner Radius: \(Int(self.innerRadius))")
        Slider(value: $innerRadius, in: 10...150, step: 1)
          .padding([.horizontal, .bottom])
        Text("Outer Radius: \(Int(self.outerRadius))")
        Slider(value: $outerRadius, in: 10...150, step: 1)
          .padding([.horizontal, .bottom])
        Text("Distance: \(Int(self.distance))")
        Slider(value: $innerRadius, in: 1...150, step: 1)
          .padding([.horizontal, .bottom])
        Text("Amount: \(self.amount, specifier: "%.2f")")
        Slider(value: $amount)
          .padding([.horizontal, .bottom])
        Text("Color")
        Slider(value: $hue)
          .padding([.horizontal])
      }
    }
  }
}
