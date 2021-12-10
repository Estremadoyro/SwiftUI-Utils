//
//  OnDeleteView.swift
//  StateSheetDelete
//
//  Created by Leonardo  on 9/11/21.
//

import SwiftUI

struct OnDeleteView: View {
  @State private var numbers: Array = [Int]()
  @State private var currentNumber: Int = 1

  func removeRows(at offsets: IndexSet) {
    self.numbers.remove(atOffsets: offsets)
  }

  var body: some View {
    NavigationView {
      VStack {
        List {
          /// # onDelete only works with ForEach
          ForEach(self.numbers, id: \.self) {
            Text("Row \($0)")
          }
          .onDelete(perform: removeRows)
        }
        Button("Add number") {
          self.numbers.append(self.currentNumber)
          self.currentNumber += 1
        }
      }
      .navigationTitle("onDelete")
      .toolbar {
        EditButton()
      }
    }
  }
}

struct OnDeleteView_Previews: PreviewProvider {
  static var previews: some View {
    OnDeleteView()
  }
}
