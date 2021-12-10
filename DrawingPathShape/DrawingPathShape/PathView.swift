//
//  PathView.swift
//  DrawingPathShape
//
//  Created by Leonardo  on 19/11/21.
//

import SwiftUI

struct PathView: View {
  var body: some View {
    /// # `PATHS` measure coordinates from `TOP LEFT CORNER`
    Path { path in
      /// # `CG` CoreGraphics
      ///  # Need to use `exact coordinates`
      path.move(to: CGPoint(x: 200, y: 100))
      /// # Lines are drawn `consequitevly` from starting point (`path.move`)
      path.addLine(to: CGPoint(x: 100, y: 300))
      path.addLine(to: CGPoint(x: 300, y: 300))
      path.addLine(to: CGPoint(x: 200, y: 100))
      /// # `closeSubPath` no longer needed when `StrokeStyle` is specified
      // path.closeSubpath()
    }
    /// # Add `border`
    /// # `StrokeStyle` gives control on how every line is connected
    .stroke(Color.purple, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
    /// # `Fill` color
    // .fill(Color.purple)
  }
}
