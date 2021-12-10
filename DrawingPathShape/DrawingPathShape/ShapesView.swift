//
//  ShapesView.swift
//  DrawingPathShape
//
//  Created by Leonardo  on 19/11/21.
//

import SwiftUI

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxX))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    path.closeSubpath()
    return path
  }
}

/// # `strokeBorder` only works with protocols that conform the `InsettableShape`, like `Circle`
/// # `InsettableShape` build upon `Shape` so there is no need to specify both
struct Arc: InsettableShape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool
  /// # Higher the `inset` is, smaller the `CGRect` canvas will be
  var insetAmount = 0.0

  func path(in rect: CGRect) -> Path {
    let rotationAdjustment: Angle = .degrees(90)
    let modifiedStart = self.startAngle - rotationAdjustment
    let modifiedEnd = self.endAngle - rotationAdjustment
    var path = Path()
    /// # `Shapes` start from the `Bottom left`
    /// # `insetAmount` should be applied to all the edges
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: (rect.width / 2) - self.insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !self.clockwise)
    return path
  }

  /// # `CGFloat` is `Double`
  /// # In order to confom `InsettableShape`, need to implement `func inset(by: )`
  func inset(by amount: CGFloat) -> some InsettableShape {
    /// # `self` referes to "asdf"
    var arc = self
    arc.insetAmount += amount
    return arc
  }
}

struct ShapesView: View {
  var body: some View {
    VStack(spacing: 100) {
      Triangle()
        .stroke(Color.purple, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        .frame(width: 150, height: 150)
      /// # `Right` is `0 degrees`
      /// # `Top` is `+-90 degrees`
      /// # `Left` is `+-180 degrees`
      /// # `Bottom` is `+-270 degrees`
      /// # `clockwise` is the `opposite`
      Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
        /// #`[ERROR]` Value of type 'Arc' has no member 'strokeBorder'
        // .strokeBorder(Color.orange, lineWidth: 10)
        .strokeBorder(Color.blue, lineWidth: 20)
        .frame(width: 150, height: 150)
      Circle()
        /// # `strokeBorder` is drawn `inside the frame` not 50-50% as with `border`
        .strokeBorder(Color.green, lineWidth: 10)
        .frame(width: 150, height: 150)
    }
    .padding(.horizontal)
  }
}
