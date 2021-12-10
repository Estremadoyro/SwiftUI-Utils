//
//  ArrowView.swift
//  Arrow
//
//  Created by Leonardo  on 24/11/21.
//

import SwiftUI

struct Arrow: InsettableShape {
  var arrowHeight: Double
  var insetAmount = 0.0

  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: rect.minX + 50, y: rect.maxY))
    path.addLines([
      CGPoint(x: rect.maxX - 50, y: rect.maxY),
      CGPoint(x: rect.maxX - 50, y: rect.midY - arrowHeight),
      CGPoint(x: rect.maxX, y: rect.midY - arrowHeight),
      CGPoint(x: rect.midX, y: rect.minY),
      CGPoint(x: rect.minX, y: rect.maxY - rect.midY - arrowHeight),
      CGPoint(x: rect.minX + 50, y: rect.maxY - rect.midY - arrowHeight),
      CGPoint(x: rect.minX + 50, y: rect.maxY)
    ])
    path.closeSubpath()
    return path
  }

  func inset(by amount: CGFloat) -> some InsettableShape {
    var arrow = self
    arrow.insetAmount += 0
    return arrow
  }
}

struct ArrowView: View {
  @State private var arrowHeight = 50.0
  @State private var arrowBorderWidth = 2.0
  var body: some View {
    VStack {
      Arrow(arrowHeight: self.arrowHeight)
        .strokeBorder(Color.purple, style: StrokeStyle(lineWidth: self.arrowBorderWidth, lineCap: .round, lineJoin: .round))
        .frame(width: 200, height: 400)
        .contentShape(Rectangle())
        .onTapGesture {
          withAnimation {
            self.arrowBorderWidth = (self.arrowBorderWidth == 10.0 ? 1.0 : 10.0)
          }
        }
      Text("Height: \(self.arrowHeight, specifier: "%.2f")")
        .padding(.top)
      Slider(value: $arrowHeight, in: 50 ... 100, step: 1)
    }
  }
}
