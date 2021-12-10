//
//  ImagePaintView.swift
//  CGAffineImagePaintDrawingGroup
//
//  Created by Leonardo  on 21/11/21.
//

import SwiftUI

struct ImagePaintView: View {
  var body: some View {
    VStack {
      Text("Arcane")
        .frame(width: 300, height: 300)
        .background(Color.pink)
        /// # Can't add `Images` to borders
        // .border(Image("senku"), width: 20)
        /// # `sourceRect` creates a `CGRect` (rectangle) inside the `Image`
        .border(ImagePaint(image: Image("senku"), sourceRect: CGRect(x: 0, y: 0, width: 1, height: 0.5), scale: 0.2), width: 30)
      Capsule()
        .strokeBorder(ImagePaint(image: Image("senku"), scale: 0.1), lineWidth: 20)
        .frame(width: 300, height: 200)
    }
  }
}
