//
//  ImageLoader.swift
//  URLSessionCodableDisable
//
//  Created by Leonardo  on 9/12/21.
//

import Combine
import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
  @Published var image: UIImage?
  private let url: URL
  private var cancellable: AnyCancellable?

  init(url: URL) {
    self.url = url
  }

  func load() {
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      /// # `weak self` prevents the reference cycle happening from `UIImage`
      .sink { [weak self] in self?.image = $0 }
  }

  func cancel() {
    cancellable?.cancel()
  }

  deinit {
    self.cancel()
  }
}

/// # Generic `T` that conforms the `View protocol`
struct AsyncImageComponentView<T: View>: View {
  @StateObject private var loader: ImageLoader
  private let placeholder: T

  /// # Custom initializer
  /// # `@ViewBuilder` can only be applied to function type parameter
  init(url: URL, @ViewBuilder placeholder: () -> T) {
    self.placeholder = placeholder()
    /// # `_loader` the `_` targets `@StateObject` properties
    _loader = StateObject(wrappedValue: ImageLoader(url: url))
  }

  var body: some View {
    self.content
      .onAppear(perform: self.loader.load)
  }

  private var content: some View {
    Group {
      if loader.image != nil {
        Image(uiImage: loader.image!)
          .resizable()
      } else {
        self.placeholder
      }
    }
  }
}
