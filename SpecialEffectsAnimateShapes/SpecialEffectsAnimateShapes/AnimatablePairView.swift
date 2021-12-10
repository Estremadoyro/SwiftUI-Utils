//
//  AnimatablePairView.swift
//  SpecialEffectsAnimateShapes
//
//  Created by Leonardo  on 22/11/21.
//

import SwiftUI

struct Checkerboard: Shape {
  var rows: Int
  var columns: Int

  /// # `AnimatablePair` is needed to animate `2+ properties`
  /// # `AnimatablePair` CANNOT be `INT`
  var animatableData: AnimatablePair<Double, Double> {
    get {
      /// # `.withAnimation()` requires `Doubles` in order to create `intermediate values`
      return AnimatablePair(Double(self.rows), Double(self.columns))
    }
    /// # This runs when the `@State updates` and the view creates a new instance of `Chckerboard struct`
    set {
      /// # The `AnimatablePair<Double, Double>` needs to `get`
      /// # `newValue` conforms to `AnimatableData's Type` (Double, Double)
      self.rows = Int(newValue.first)
      self.columns = Int(newValue.second)
    }
  }

  func path(in rect: CGRect) -> Path {
    var path = Path()
    /// # Determine `row & column` width
    let rowSize = rect.height / Double(self.rows)
    let columnSize = rect.width / Double(self.columns)

    for row in 0 ..< self.rows {
      for column in 0 ..< self.columns {
        if (row + column).isMultiple(of: 2) {
          let startX = columnSize * Double(column)
          let startY = rowSize * Double(row)
          let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
          path.addRect(rect)
        }
      }
    }
    return path
  }
}

struct AnimatablePairView: View {
  /// # There is no `3.8, 3.9, 4.0` in an `Int`, so there are `no intermediate` values
  /// # Properties must be `Doubles` in order to animate properly
  @State private var rows: Int = 4
  @State private var columns: Int = 4
  var body: some View {
    Checkerboard(rows: self.rows, columns: self.columns)
      .onTapGesture {
        withAnimation(.linear(duration: 1)) {
          self.rows = 8
          self.columns = 8
        }
      }
  }
}
