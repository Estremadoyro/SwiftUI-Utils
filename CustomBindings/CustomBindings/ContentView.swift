import SwiftUI

struct ContentView: View {
  @State private var agreedToTerms: Bool = false
  @State private var agreedToPrivacyPolicy: Bool = false
  @State private var agreedToEmails: Bool = false

  @State var selection: Int = 0
  let starters = ["Bulbasaur", "Charmander", "Squirtle"]
  var body: some View {
    let binding = Binding(get: { self.selection }, set: { self.selection = $0 })
    let agreedToAll = Binding<Bool>(
      get: {
        /// # Be toggled ON if the rest are on
        self.agreedToTerms && self.agreedToPrivacyPolicy && self.agreedToEmails
      },
      set: { agree in
        /// # So, it also toggles the rest on/off
        /// # $0 is the first argument -> agreedToAll value
        self.agreedToTerms = agree
        self.agreedToPrivacyPolicy = agree
        self.agreedToEmails = agree
      }
    )

    Form {
      Section(header: Text("Select starter")) {
        VStack {
          Picker("Select a number", selection: binding) {
            ForEach(0 ..< starters.count) { pokemon in
              Text("\(starters[pokemon])")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          HStack {
            Text("Selection:")
            Text(starters[selection])
              .font(.title3)
              .bold()
          }
        }
      }
      Section(header: Text("Terms and conditions")) {
        VStack {
          Toggle(isOn: $agreedToTerms) {
            Text("Agree to terms")
          }
          Toggle(isOn: $agreedToPrivacyPolicy) {
            Text("Agree to privacy policy")
          }
          Toggle(isOn: $agreedToEmails) {
            Text("Agree to recieve shipping emails")
          }
          Toggle(isOn: agreedToAll) {
            Text("Agree to all")
              .bold()
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
