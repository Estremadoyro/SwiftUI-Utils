//
//  Observables.swift
//  StateSheetDelete
//
//  Created by Leonardo  on 8/11/21.
//

import SwiftUI
/// # Structs, create a new instance whenever we change one of its properties
/// # However, a Class, doesn't need that, and instances of it can point to the same memory allocation
/// # Observable obj. so it can be seen
class User: ObservableObject {
  /// # Tell swift which properties should be exposed
  /// # Whenever any of these change, tell swift the view must be reloaded
  @Published var firstName: String = "Leonardo"
  @Published var lastName: String = "Estremadoyro"
}

struct ObservablesView: View {
  /// # Whenever user properties get updated, it creates a whole new User struct
  /// # State can only listen to struct changes
  /// # Now that user is a class type, it doesn't create a new one when updated, so @State cannot keep track of it and rerender the body property
  /// # Watch any changes from this class, private is not necessary, as @StateObject is already designed to be share
  @StateObject var user = User()
  /// # @StateObject, when made the first time
  /// # @ObservedObject, when used but not created

  var body: some View {
    VStack {
      Text("My name is \(self.user.firstName) \(self.user.lastName)")
      TextField("First name", text: $user.firstName)
      TextField("Last name", text: $user.lastName)
    }
    .padding()
  }
}
struct ObservableView_Previews: PreviewProvider {
  static var previews: some View {
    ObservablesView()
  }
}
