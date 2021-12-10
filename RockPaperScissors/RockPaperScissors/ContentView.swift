import SwiftUI

enum Result {
  case win
  case tie
  case loss
}

class GameSettings: ObservableObject {
  @Published var turns: Int = 1
  @Published var playerPoints: Int = 0
}

struct RockPaperScissors: View {
  var selection: Image

  var body: some View {
    selection
      .renderingMode(.original)
      .resizable()
      .scaledToFit()
      .shadow(color: Color.black, radius: 2)
      .frame(width: 75, height: 75)
  }
}

struct ResultsView: View {
  @EnvironmentObject var settings: GameSettings

  var body: some View {
    VStack {
      HStack {
        Text("Final score: ")
        Text("\(settings.playerPoints)")
          .bold()
      }
      Button(action: {
        settings.turns = 1
        settings.playerPoints = 0
      }, label: {
        Text("Play again?")
          .padding()
          .foregroundColor(Color.white)
          .background(RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .background(Color.gray))
      })
    }
    .foregroundColor(Color.white)
    .font(.title)
  }
}

struct GameView: View {
  let options: [String] = ["rock", "paper", "scissors"]

  @EnvironmentObject var settings: GameSettings

  @State private var playerSelection: Int = 0
  @State private var shouldWin = Bool.random()
  @State private var roundStart: Bool = false
  @State private var gameSelection = Int.random(in: 0 ..< 3)

  var checkWinner: Result {
    if playerSelection == gameSelection {
      print("tie")
      return Result.tie
    }
    switch (playerSelection, gameSelection) {
      case (0, 2), (1, 0), (2, 1):
        print("win")
        return shouldWin ? Result.win : Result.loss
      default:
        print("loss")
        return !shouldWin ? Result.win : Result.loss
    }
  }

  func playGame() {
    if checkWinner == Result.win {
      settings.playerPoints += 1
    }
    if settings.turns > 9 {
      print("game over")
      settings.playerPoints = 0
      return
    }
    settings.turns += 1
    print(settings.turns)
    shouldWin = Bool.random()
    gameSelection = Int.random(in: 0 ..< 3)
  }

  var body: some View {
    VStack {
      HStack {
        Text("Round:")
        Text("\(settings.turns) / 10")
          .bold()
      }
      .padding(.bottom, 100)
      HStack {
        Text("Player should... ")
        Text(shouldWin ? "Win" : "Lose")
          .bold()
          .foregroundColor(shouldWin ? .green : .red)
      }
      .padding(.bottom, 25)
      HStack {
        ForEach(0 ..< options.count) { option in
          Button(action: {
            self.playerSelection = option
            playGame()
            print(options[option])
          }) {
            RockPaperScissors(selection: Image(options[option]))
          }
        }
      }
      .padding(.bottom, 100)
      HStack {
        Text("iPhone picked:")
        RockPaperScissors(selection: Image(options[gameSelection]))
        // .blur(radius: settings.turns == 1 ? 18 : 0)
      }
      HStack {
        Text("Points:")
        Text("\(settings.playerPoints)")
          .bold()
      }
      .padding(.top, 100)
    }
    .foregroundColor(Color.white)
    .font(.title)
  }
}

struct ContentView: View {
  @StateObject var settings = GameSettings()

  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
      if settings.turns == 10 {
        ResultsView()
      } else {
        GameView()
      }
    }
    .environmentObject(settings)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
      ContentView()
    }
  }
}
