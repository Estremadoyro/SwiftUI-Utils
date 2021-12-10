//
//  CGAffineView.swift
//  CGAffineImagePaintDrawingGroup
//
//  Created by Leonardo  on 20/11/21.
//

import SwiftUI

struct Flower: Shape {
  /// # How much `move each petal` away from the center
  var petalOffset: Double = -20
  /// # How `wide` to make this petal
  var petalWidth: Double = 100

  func path(in rect: CGRect) -> Path {
    /// # This `Path()` will hold all petals
    var path = Path()
    /// # A `180` rotation is `1PI`, meaning full `360` is `2PI`
    /// # Making `16 petals` means going moving `1/8PI` per petal
    /// # `stride(from:, to:, by: )` Goes from X to Y multiplying `X * BY`
    for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
      /// # Create the `path` for `number` petal, using properties and a `fixed` X & Y
      let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
      /// # `Rotate the petal` by the current value of the view
      /// # `0, PI/8, PI/4, PI/2 etc...`
      let rotation = CGAffineTransform(rotationAngle: number)
      /// # `Move` the petal to be at the `center` of the view
      /// # The `translationX` is gonna be `half` of the `width` of the petal
      let position = CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2)
      /// # `Concatenate` transformations in one
      let combinedTransformations = rotation.concatenating(position)
      /// # Apply `rotation/position` tranformation to the petal
      let rotatedPetal = originalPetal.applying(combinedTransformations)
      /// # Add it to the main path created
      path.addPath(rotatedPetal)
    }
    /// # Send the `main path` back
    return path
  }
}

struct CGAffineView: View {
  @State private var petalOffset = -20.0
  @State private var petalWidth = 100.0

  var body: some View {
    VStack {
      Flower(petalOffset: self.petalOffset, petalWidth: self.petalWidth)
        // .stroke(Color.purple, lineWidth: 1)
        .fill(.purple, style: FillStyle(eoFill: true))
      Text("Offset: \(self.petalOffset, specifier: "%.2f")")
      Slider(value: $petalOffset, in: -40...40, step: 1)
        .padding([.horizontal, .bottom])
      Text("Width: \(self.petalWidth, specifier: "%.2f")")
      Slider(value: $petalWidth, in: 0...100, step: 1)
        .padding(.horizontal)
    }
  }
}
