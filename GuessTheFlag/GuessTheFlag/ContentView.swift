import SwiftUI

/// View which takes an Image and returns it with modifiers applied to it
struct FlagImage: View {
  var flag: Image
  var body: some View {
    flag
      .renderingMode(Image.TemplateRenderingMode.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: Color.black, radius: 6)
  }
}

/// The problem when modifiying an Image View is that the modifiers can only be applied
/// to an Image, hence content can only be one thing, so the applied modifiers cannot infer what is it
/// as one of them like .renderingMode can only work with Image, Swift can't infer what content is
/// Unlike the rest .clipShape .overlay or .shadow that can be applied to any some View
struct Flag: ViewModifier {
  func body(content: Content) -> some View {
    content
      /// This modifier will need to be applied directly as an extension of Image,
      /// some View can't infer what content is
      // .renderingMode(Image.TemplateRenderingMode.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: Color.black, radius: 6)
  }
}

extension View {
  func flagStyle() -> some View {
    modifier(Flag())
  }
}

struct ContentView: View {
  @State private var resultColor: Color = .blue
  @State private var alertMessage: String = ""
  @State private var alertDescription: String = ""
  @State private var lifes: Int = 3
  @State private var playerScore: Int = 0
  @State private var selectedFlag: Int = 0
  @State private var showingScore: Bool = false
  @State private var scoreTitle: String = ""
  @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0 ... 2)
  @State private var isCorrectAnswer: Bool = false
  @State private var isIncorrectAnswer: Bool = false
  @State private var btnSelected: Int = 0
  @State private var onGoingAnimations: Bool = false

  /// # Rotation state
  @State private var correctAnswerAnimation: [CGFloat] = [0.0, 0.0, 0.0]
  /// # Opacity state
  @State private var opacityAnimation: Bool = false

  var incorrect: Void {
    if playerScore > 0 {
      playerScore -= 1
    }
    lifes -= 1
    alertMessage = "Wrong"
    alertDescription = "That's the flag of \(countries[selectedFlag])"
    resultColor = .red
    print("incorrect")
  }

  var correct: Void {
    askQuestion
    playerScore += 1
    resultColor = .green
    print("correct")
  }

  var askQuestion: Void {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
      countries.shuffle()
      correctAnswer = Int.random(in: 0 ... 2)
      isCorrectAnswer = false
      isIncorrectAnswer = false
    }
  }

  var lostGame: Void {
    lifes = 3
    playerScore = 0
    alertMessage = "You lost"
    alertDescription = "Better luck next time owo"
    print("lost game")
  }

  func flagTapped(_ selection: Int) {
    btnSelected = selection
    opacityAnimation = true
    onGoingAnimations = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
      opacityAnimation = false
      onGoingAnimations = false
    }
    if selection == correctAnswer {
      correctAnswerAnimation[selection] += 360
      isCorrectAnswer = true
      correct
    } else {
      showingScore = true
      isIncorrectAnswer = true
      if lifes < 2 {
        lostGame
        return
      }
      incorrect
    }
  }

  var body: some View {
    return ZStack {
      LinearGradient(gradient: Gradient(colors: [resultColor, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
      // Spaces each view
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of... ")
            .foregroundColor(Color.white)
          Text(countries[correctAnswer])
            .foregroundColor(Color.white)
            .font(.largeTitle)
            .fontWeight(.ultraLight)
        }
        ForEach(0 ..< 3) { number in
          Button(action: {
            selectedFlag = number
            withAnimation {
              flagTapped(number)
            }
          }) {
            FlagImage(flag: Image(self.countries[number]))
              .rotation3DEffect(.degrees(correctAnswerAnimation[number]), axis: (x: 0, y: 1, z: 0))
              .opacity(self.isCorrectAnswer && self.opacityAnimation && !(self.btnSelected == number) ? 0.25 : 1)
              .overlay(
                ZStack {
                  Rectangle()
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .foregroundColor(.pink)
                  Text("Wrong !")
                    .font(.title)
                    .foregroundColor(.white)
                }
                .opacity(isIncorrectAnswer && self.btnSelected == number ? 1 : 0)
                .animation(Animation.easeIn(duration: 1), value: opacityAnimation)
              )
              .animation(Animation.easeIn(duration: 1), value: opacityAnimation)
          }
          .disabled(self.onGoingAnimations)
        }
        HStack {
          Text("Score:")
            .fontWeight(.ultraLight)
          Text("\(playerScore)")
            .fontWeight(.medium)
        }
        // These are environment modifiers, as they are applied to more than 1 View
        .foregroundColor(Color.white)
        .font(.title)
        HStack {
          ForEach(0 ..< lifes, id: \.self) { _ in
            Image(systemName: "heart")
              .resizable()
              .frame(width: 50, height: 50)
              .foregroundColor(Color.red)
          }
        }
      }
    }
    .alert(isPresented: $showingScore) {
      Alert(title: Text(alertMessage), message: Text(alertDescription), dismissButton: .default(Text("Continue")) {
        self.askQuestion
        self.onGoingAnimations = false
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
