//
//  CodableConformanceView.swift
//  URLSessionCodableDisable
//
//  Created by Leonardo  on 8/12/21.
//

import SwiftUI

/// # Custom implementation of `Codable` if there are properties that `do not conform codable`
/// # like ones with the `@Published` wrapper
/// # Also allows to control what `data is saved and how it happens`
final class User: ObservableObject, Codable {
  /// # Since `@Published` doesn't conform `Codable`, we need to tell Swift which properties of `User` are the ones which are required to `Code & Uncode`
  /// # Tells swift which properties should be `loaded & saved`
  enum CodingKeys: CodingKey {
    case name
  }

  @Published var name: String = "Leonardo Estremadoyro"

  /// # Need an method to `encode` the data
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.name, forKey: CodingKeys.name)
  }

  /// # Create a `REQUIRED` initializer, which will be given a `container` used to read values for the properties
  /// # Or mark the `User class` as `final`
  init(from decoder: Decoder) throws {
    /// # This daat should have a container where the keys match whatever is in the `CodingKeys` enum
    let container = try decoder.container(keyedBy: CodingKeys.self) /// `.self` gives the Obj. type
    self.name = try container.decode(String.self, forKey: CodingKeys.name)
  }
}

struct CodableConformanceView: View {
  var body: some View {
    Text("owo")
  }
}
