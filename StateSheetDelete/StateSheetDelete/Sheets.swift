//
//  Sheets.swift
//  StateSheetDelete
//
//  Created by Leonardo  on 8/11/21.
//

import SwiftUI

struct SecondView: View {
  /// # But you can also dismiss it programmatically
  @Binding var isPresented: Bool

  let name: String
  var body: some View {
    VStack {
      Text("Hello \(self.name)")
      Button(action: {
        self.isPresented = false
      }) {
        Text("Dismiss me owo")
      }
    }
  }
}

struct SheetsView: View {
  @State private var showingSheet: Bool = false
  var body: some View {
    Button(action: {
      self.showingSheet.toggle()
    }) {
      Text("Show sheet")
    }
    /// # A sheet can be dismissed by swiping down
    .sheet(isPresented: $showingSheet) {
      SecondView(isPresented: $showingSheet, name: "Leonardo")
    }
  }
}

struct SheetsView_Previews: PreviewProvider {
  static var previews: some View {
    SheetsView()
  }
}
