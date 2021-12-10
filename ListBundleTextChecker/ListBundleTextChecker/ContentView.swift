import SwiftUI

struct ContentView: View {
  var body: some View {
    /// # Search for the URL named after forResource, its an opitonal as it may not be found
    if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
      /// # If file is found, then try to load it, as it may fail we need to try/catch it
      if let fileContents = try? String(contentsOf: fileURL) {
        /// # file succesfully loaded
        Text("file? \(fileContents)")
      }
    }

    // let input = "a b c"
    let input2 = """
    a
    b
    c
    """
    /// # Turns the string into an array of strings containing each letter
    // let letters = input.components(separatedBy: " ")
    let letters2 = input2.components(separatedBy: "/n")
    /// # Swift doesn't know randomElement's result, if the input array is empty then it may return nil, so we gotta unwrap it
    let letter = letters2.randomElement()
    /// # Remove spaces and new lines from the String we got from random
    let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)

    let word = "swift"
    /// # Class from UIKit written in Objc
    let checker = UITextChecker()
    /// # Since we are using an Objc class, unlike Swift, we need to specify the length of our word using and Objc method
    /// # Gotta specify the encoding aswell
    let range = NSRange(location: 0, length: word.utf16.count)
    /// # Check if the given word is misspelled or not
    /// # Returns an Objc range (NSRange) indicating where the misspelling was found, but if the word happened no be correct, it will return nil aka NSNotFound in Objc
    /// # Thus, it must be hanled as an optional return, but there is no unwraping ? in Objc, so we gotta do it its way
    /// wrap --> Check outside the range provided boundaries
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    /// # Check if the return is nil, if so, then the word was correclty spelled
    let allGood = misspelledRange.location == NSNotFound

    let g2: [String] = ["Rekkles", "Caps", "Wunder", "radolfo224", "Mikyx"]
    // let fnc: [String] = ["Adam", "Bwipo", "Nisqy", "Upset", "Hylissang"]

    /// # List can also be used like a ForEach, but only if all views are dynamic
    List {
      /// # Static rows
      Section(header: Text("Section 1")) {
        Text("static row 1")
        Text("static row 2")
      }

      /// # Dynamic rows
      Section(header: Text("G2 Esports")) {
        ForEach(g2, id: \.self) {
          Text($0)
        }
      }
    }
    .listStyle(GroupedListStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
