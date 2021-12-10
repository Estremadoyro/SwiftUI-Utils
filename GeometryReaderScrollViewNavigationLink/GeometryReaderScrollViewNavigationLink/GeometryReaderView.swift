//
//  GeometryReaderView.swift
//  GeometryReaderScrollViewNavigationLink
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct GeometryReaderView: View {
  var body: some View {
    /// # Geo reader always start at the top left
    GeometryReader { geo in
      Image("drstone")
        /// # Resized into square shape
        .resizable()
        /// # Will fill the whole frame, but some parts of the image won't be shown to keep the aspect ratio
        .scaledToFill()
        /// # Resized, might not fit whole dimensions in order to keep the aspect ratio
        .scaledToFit()
        /// # This wont work, content of image is till shown with original landscape
        // .frame(width: 300, height: 300)
        /// # Frame with geo reader, width will now be 80% of the width
        ///  # Height is not necessary as we are already scaling the image, SwiftUI will use the best height size
        /// # geo.size.width is the device width
        .frame(width: geo.size.width * 0.8)
        /// # This cuts the image to the frame, it doesn't fit it
        // .clipped()
        /// # If we want to center the image
        /// # Add another frame
        /// # Max width -> Vertial align
        /// # Max height -> Horizontal align
        .frame(width: geo.size.width, height: geo.size.height)
    }
  }
}
