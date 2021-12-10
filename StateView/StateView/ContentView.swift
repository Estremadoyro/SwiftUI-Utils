//
//  ContentView.swift
//  WeSplit
//
//  Created by Leonardo  on 24/09/21.
//

import SwiftUI
// ## Views are a function of their state ##
// -> The things people can see and what they can interact with
//    are determined by the state of your program

// State -> Sequence of events aproach (OLD)
// meant to re-execute all previous actions
struct ContentView: View {
  // Show the value of this property here
  @State private var tapCount: Int = 0
  // Show the value of this property here but write
  // any changes back to the property
  // Swift needs to make sure whatever is in the TextVield is
  // also in the name property
  // TWO WAY BINDING (Read, and write)
  @State private var name: String = ""

  let students: [String] = ["Harry", "Hermione", "Ron"]
  @State private var selectedStudent: String = "Harry"

  var body: some View {
    NavigationView {
      Form {
        Section {
          Text("Your name is: \(name)")
          TextField("Enter your name", text: $name)
        }
        Section {
          Text("Hello, world!")
          Button("Reset count") {
            self.tapCount = 0
          }
        }
        Button("Tap count \(tapCount)") {
          self.tapCount += 1
        }
        Picker("Select your student", selection: $selectedStudent) {
          ForEach(0 ..< students.count) {
            Text(self.students[$0])
          }
        }
        Text("Selected: \(selectedStudent)")
      }
      .navigationBarTitle(Text("SwiftUI"), displayMode: .inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
