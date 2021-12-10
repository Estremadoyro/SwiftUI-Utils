import SwiftUI

/// # ANIMATIONS BECOME A FUNCTION OF OUR STATE JUST LIKE VIEWS THEMSELVES
/// # ANIMATIONS ARE IMPLICIT IF USED WITH .animation()
struct ContentView: View {
  /// # IMPLICIT ANIMATION -> Animation created by attaching the .animation() modifier to a view
  @State private var animationAmount: CGFloat = 1
  @State private var animationAmount2: CGFloat = 1
  @State private var stepperAnimation: CGFloat = 1
  @State private var explicitAnimation: CGFloat = 0.0

  @State private var enabled: Bool = false

  @State private var dragAmount = CGSize.zero

  let letters = Array("Desire is noble")
  @State private var enable: Bool = false
  @State private var letterDrag = CGSize.zero

  @State private var isShowingRed: Bool = false

  var body: some View {
    print(stepperAnimation)

    return VStack {
      /// #2. IMPLICIT ANIMATION -> Animation can also be added to a binding, so the View doesn't know its being animated but ratter the state
      /// .animation() modifier can also be used by binder
      Stepper("Scale amount", value: $stepperAnimation.animation(Animation.easeInOut(duration: 1)
          .repeatCount(3, autoreverses: true)), in: 1 ... 10)
                .padding()
      Spacer()
      /// # 1. IMPLICIT ANIMATION -> Attaching animation() to a View, it animates ALL the effects that are inside the view
      Button("Mr. owo") {
        self.animationAmount += 1
      }
      .padding(40)
      .foregroundColor(.white)
      .background(Color.purple)
      .clipShape(Circle())
      /// # Scale the view
      .scaleEffect(animationAmount)
      /// # Blur effect
      // .blur(radius: (animationAmount - 1) * 3)

      /// # Implicit animation
      /// # All animations apply to all modifiers specified
      // .animation(.default, value: animationAmount)
      /// # Spring animation
      // .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
      /// # Customize animation duration
      /// This creates an instance of an Animation struct that has its own set of modifiers
      .animation(Animation.easeIn(duration: 1)

        /// You can customize the delay before running the animation
        .delay(0.1)
        /// Can also have an animation repeate endlessly
        // .repeatForever(autoreverses: true), value: animationAmount)

        /// You can also set a repeat count for the animation
        /// Reverses will play backwards the animation after it finishes
        .repeatCount(3, autoreverses: true), value: animationAmount)
      Button("Mrs. owo") {}
        .padding(50)
        .background(Color.pink)
        .foregroundColor(.white)
        .clipShape(Circle())
        /// # Overlay lays a view in front of the original
        .overlay(
          Circle()
            .stroke(Color.pink)
            /// Where 1 is 100%, same scale
            .scaleEffect(animationAmount2)
            /// # Where 0 is transparent (not visible) and 1 solid
            .opacity(Double(2 - animationAmount2))

            /// # THE .scaleEffect modifier is ANIMATED
            /// The scale animation can be apreciated when its original value (@State 1) changes
            .animation(Animation.easeInOut(duration: 1)
              .repeatForever(autoreverses: false), value: animationAmount2)
        )
        .onAppear {
          self.animationAmount2 = 2
        }
      HStack {
        Button("Sir. owo") {
          self.stepperAnimation += 1
        }
        /// # The binding is the one animating the view actually
        .padding(40)
        .background(Color.green)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(stepperAnimation)
        /// # 3. EXPLICIT ANIMATIONS -> Animations not attached to a view, nor attached to a $binding.
        /// ANIMATE CHANGES OCURRING AS THE RESULT OF A STATE CHANGE
        Button("Dr. owo") {
          /// This would make the change happen inmediatly, as there is no .animation() modifier
          // self.explicitAnimation += 360
          /// # EXPLICIT ANIMATION DECLARATION
          /// Animate the precise change you want to make.
          /// # Only those parameters that depend on a value changed inside withAnimation { } will be animated
          /// It also accepts all the Animations types
          withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
            self.explicitAnimation += 360
          }
        }
        .padding(50)
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(explicitAnimation), axis: (x: 0, y: 1, z: 0))
      }

      Button("Tap me") {
        self.enabled.toggle()
      }
      .foregroundColor(Color.white)
      .frame(width: 100, height: 100)
      .background(enabled ? Color.blue : Color.red)
      /// # .nil animation will NOT animated anything before it
      // .animation(nil, value: enabled)
      /// # The order of the animation is applied MATTERS
      .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
      .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
      LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
        .frame(width: 200, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 5)
        /// It only takes a CGSize or x & y coordinates
        .offset(dragAmount)
        .gesture(
          DragGesture()
            /// # Drag
            .onChanged { position in self.dragAmount = position.translation }
            /// # Release
            .onEnded { _ in
              /// # EXPLICIT ANIMATION
              /// This only animates the RELEASE effect
              withAnimation(Animation.spring()) {
                self.dragAmount = .zero
              }
            }
        )
      /// # IMPLICIT ANIMATION
      /// This animates the DRAG and RELEASE
      // .animation(Animation.spring(), value: dragAmount)
      HStack(spacing: 0) {
        ForEach(0 ..< letters.count) { num in
          Text(String(self.letters[num]))
            .padding(5)
            .font(.title)
            .background(self.enable ? Color.blue : Color.green)
            .offset(self.letterDrag)
            .animation(Animation.default.delay(Double(num) / 20), value: self.letterDrag)
        }
      }
      .gesture(DragGesture()
        .onChanged { position in
          self.letterDrag = position.translation
        }
        .onEnded { _ in
          self.letterDrag = CGSize.zero
          self.enable.toggle()
        }
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
