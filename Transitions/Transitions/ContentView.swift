import SwiftUI

/// # CANVAS DOESNT SHOW TRANSITIONS PROPERLY -- 14/10/2021
/// # Custom Trasnsitions with ViewModifier
/// Thanks to the .modifier TRANSITION

struct CornerRotateModifier: ViewModifier {
  let amount: Double
  let anchor: UnitPoint

  func body(content: Content) -> some View {
    content
      .rotationEffect(.degrees(amount), anchor: anchor)
      /// # When the view rotates, the parts that will be shown outside its natural canvas WONT get drawn
      .clipped()
  }
}

extension AnyTransition {
  /// # MUST BELONG TO THE TYPE (AnyTransition) RATHER THAN INSTANCES OF IT (AnyTransition)
  /// If wanted the be used insde a .transition() modifier or passed in as a TYPE
  static var pivot: AnyTransition {
    AnyTransition.modifier(
      active: CornerRotateModifier(amount: -90, anchor: .topLeading),
      identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
    )
  }

  static func pivot_fn() -> AnyTransition {
    /// # Depends on 2 states
    AnyTransition.modifier(
      /// # Applied when -> View is gone
      active: CornerRotateModifier(amount: -90, anchor: .topLeading),
      /// # Applied when -> View is fully inserted
      identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
    )
  }
}

struct ContentView: View {
  @State private var isRed: Bool = false

  var body: some View {
    Button("Senku") {
      /// # This will animate BOTH Views as they both depend on isRed state, withAnimation {} animates all Views that depend on isRed
      withAnimation {
        self.isRed.toggle()
      }
    }
    .foregroundColor(Color.white)
    .font(.title)
    .frame(width: 200, height: 100)
    .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
    .clipShape(RoundedRectangle(cornerRadius: 25))
    .shadow(radius: 10)

    if isRed {
      Rectangle()
        .fill(Color.red)
        .frame(width: 200, height: 100)
        // .transition(.scale)
        /// # ASYMETRIC transition, 2 transitions, one when shown and the other when disappearing
        // .transition(.asymmetric(insertion: .scale, removal: .opacity))
        /// # CUSTOM transition
        /// # IT TAKES AN AnyTransition TYPE, NOT AN INSTANCE
        .transition(AnyTransition.pivot)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
