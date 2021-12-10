//
//  AnimateDataView.swift
//  SpecialEffectsAnimateShapes
//
//  Created by Leonardo  on 22/11/21.
//

import SwiftUI

struct Trapezoid: Shape {
  var insetAmount: Double
  var animatableData: Double {
    get { insetAmount }
    /// # `SwiftUI` will set the `animatableData` property to the `latest value` by `default`, so it skips the `intermediate animation values` created by `withAnimation()`
    /// # `Unless` we manually tell `Swiftui` to update the data with `all the intermediate values sent` and not with `only the latest`
    set { insetAmount = newValue }
  }

  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.maxY))
    path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.maxY))
    path.addLine(to: CGPoint(x: 0, y: rect.maxY))
    path.closeSubpath()
    return path
  }
}

struct AnimateDataView: View {
  @State private var insetAmount = 50.0

  var body: some View {
    /// # The new `insetAmount` will be passed `directly` onto `Trapezoid` and `NOT` the `intermediate values` created during the `animation process`
    /// # That's why the `Trapezoid` jumps from inset to inset, it has `no idea an animation is even happening`
    Trapezoid(insetAmount: self.insetAmount)
      .fill(Color.purple)
      // .stroke(Color.purple, lineWidth: 2)
      .frame(width: 200, height: 100)
      .onTapGesture {
        /// # `1.` Examines state of the view `before` binding changes
        /// # `2.` Examines state of the view `after` binding changes
        /// # `3.` Applies `animations`
        withAnimation {
          self.insetAmount = Double.random(in: 10 ... 90)
        }
      }
  }
}
