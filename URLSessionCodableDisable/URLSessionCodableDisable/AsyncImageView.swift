//
//  AsyncImageView.swift
//  URLSessionCodableDisable
//
//  Created by Leonardo  on 9/12/21.
//

import SwiftUI

struct AsyncImageView: View {
  let url = URL(string: "https://hws.dev/img/logo.png")!
  var body: some View {
    AsyncImageComponentView<Text>(
      url: self.url, placeholder: { Text("Loading ...") }
    ).aspectRatio(contentMode: .fill)
  }
}

struct AsyncImageView_Previews: PreviewProvider {
  static var previews: some View {
    AsyncImageView()
      .preferredColorScheme(.dark)
  }
}
