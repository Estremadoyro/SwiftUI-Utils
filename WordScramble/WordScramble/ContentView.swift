import SwiftUI

struct NewWordBtn: ViewModifier {
  /// # content --> The content view type passed to body
  func body(content: Content) -> some View {
    content
      .padding(10)
      .foregroundColor(.black)
      .clipShape(Capsule())
      .overlay(RoundedRectangle(cornerRadius: 25)
        .stroke(Color.black, lineWidth: 5))
  }
}

struct WordTextField: ViewModifier {
  func body(content: Content) -> some View {
    content
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .autocapitalization(.none)
      .padding()
  }
}

extension Text {
  func btnText() -> some View {
    /// # Applying the bold modifier as it only works with Text types
    bold().modifier(NewWordBtn())
  }
}

struct ContentView: View {
  /// # Empty array
  @State private var usedWords = [String]()
  @State private var rootWord: String = ""
  @State private var newWord: String = ""

  @State private var errorTitle: String = ""
  @State private var errorMessage: String = ""
  @State private var showingError: Bool = false

  /// # All words from the .txt
  @State private var allWords = [String]()

  /// # Points
  @State private var totalPoints: Int = 0
  @State private var wordPoints: Int = 0
  @State private var letterPoints: Int = 0

  /// # Calculate score
  func calculateScore(word: String) {
    letterPoints = word.count
    wordPoints += 5
    totalPoints = letterPoints + wordPoints
  }

  /// # Check if word hasn't been entered before
  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
  }

  /// # Check if a word can be made out of the rootWord
  /// # Copy the rootWord and loop over the input word to check if a letter is contained, then remove it from the copy and so on
  func isPossible(word: String) -> Bool {
    var tempWord = rootWord.lowercased()
    print(word)
    for letter in word {
      /// # Search and find the first instance of the word's letter in rootWord, returns an Index if found
      if let poss = tempWord.firstIndex(of: letter) {
        /// # Removes the letter at possition "poss" from rootWord (tempWord)
        tempWord.remove(at: poss)
      } else { return false }
    }
    return true
  }

  /// # Check if it's an actual word, aka check for misspelled words
  func isReal(word: String) -> Bool {
    /// # Initialize text checker
    let checker = UITextChecker()
    /// # Needs to specify the NSRange of the String as we are gonna use an Objc library
    let range = NSRange(location: 0, length: word.utf16.count)
    /// # Get the position where the word is misspelled
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    /// # Return true if
    return misspelledRange.location == NSNotFound
  }

  /// # Check word is not the same
  func isDifferentWord(word: String) -> Bool {
    return word != rootWord
  }

  /// # Check word has at least 3 letters
  func hasMinLetters(word: String, length: Int) -> Bool {
    return word.count >= length
  }

  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    showingError = true
  }

  func startGame() {
    /// # 1. Find the start.txt in the app Bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      /// # 2. Load start.txt into a String
      if let startWords = try? String(contentsOf: startWordsURL) {
        /// # 3. Split the string up into an array of strings, splitting on line breaks
        allWords = startWords.components(separatedBy: "\n")
        /// # 4. Pick one random word, or use "gaming" as sensible default
        rootWord = allWords.randomElement() ?? "gaming"
        /// # If everything worked just fine then exit
        return
      }
    }
    fatalError("Could not load start.txt from bundle")
  }

  /// # Select a new word and reset the used words list
  func resetGame() {
    rootWord = allWords.randomElement() ?? rootWord
    usedWords = [String]()

    wordPoints = 0
    letterPoints = 0
    totalPoints = 0
  }

  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    guard answer.count > 0 else { return }

    // Extra validation
    if !isOriginal(word: answer) {
      wordError(title: "Word used already", message: "Be more original")
      return
    }
    if !isPossible(word: answer) {
      wordError(title: "Word contains invalid letters", message: "You can't just make them up")
      return
    }
    if !isReal(word: answer) {
      wordError(title: "Word not possible", message: "That isn't a real word lol")
      return
    }

    if !isDifferentWord(word: answer) {
      wordError(title: "Word not allowed", message: "You can't enter the same word")
      return
    }

    if !hasMinLetters(word: answer, length: 3) {
      wordError(title: "Word too short", message: "The word must have at least 3 letters")
      return
    }

    calculateScore(word: answer)

    usedWords.insert(answer, at: 0)
    newWord = ""
  }

  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .modifier(WordTextField())
        List(0 ..< usedWords.count, id: \.self) { word in
          HStack {
            Image(systemName: "\(usedWords[word].count).circle")
            Text(usedWords[word])
          }
        }
        VStack {
          HStack {
            Text("Word Points: \(wordPoints)")
            Text("Letter Points: \(letterPoints)")
          }
          Text("Total Points: \(totalPoints)")
            .font(.headline)
        }
      }
      .navigationBarItems(trailing:
        Button(action: resetGame) {
          Text("New word")
            .btnText()
          // .modifier(NewWordBtn())
        })
      .navigationBarTitle(rootWord)
      /// # Run a method when a View is shown
      .onAppear(perform: startGame)
      /// # Alert to show when an error has been made
      .alert(isPresented: $showingError) {
        Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
