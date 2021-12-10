//
//  StoreSettings.swift
//  StateSheetDelete
//
//  Created by Leonardo  on 8/11/21.
//

import SwiftUI

/// # STORE NO MORE THAN 512KB (0.5MB)
/// # If the App dies right after a stored property was it updated, it will not be saved, swift takes some seconds to actually save it
struct StoreSettingsView: View {
  /// # AppStorage cannot save complex data types, like structs in a good fashion
  /// # It should only be used for basic data types
  ///  # The key doesn't need to be used again, as it will be binded to the tapCount property
  @AppStorage("tapCount") private var tapCount: Int = 0
  /// # However UserDefaults can handle data better
  /// # Recieves 0 if the locally stored property cannt be found (Because of .integer())
  @State private var tap = UserDefaults.standard.integer(forKey: "Tap")

  var body: some View {
    Button(action: {
      self.tapCount += 1
      self.tap += 1
      UserDefaults.standard.set(self.tap, forKey: "Tap")
    }) {
      Text("tapCount: \(self.tapCount) | tap: \(self.tap)")
    }
  }
}

struct StoreSettingsView_Previews: PreviewProvider {
  static var previews: some View {
    StoreSettingsView()
  }
}
