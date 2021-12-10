import SwiftUI

/// # With a Content type property, not a func type
struct NotificationView<Content: View>: View {
  let content: Content

  init(@ViewBuilder content: () -> Content) {
    /// Property self.content is assigned to method content() passed in as parameter
    self.content = content()
  }

  var body: some View {
    self.content
      .padding()
      .background(Color(.tertiarySystemBackground))
      .cornerRadius(16)
      .transition(.move(edge: .top))
      .animation(.spring())
  }
}

struct NotificationViewFunc<Content: View>: View {
  /// # Function that returns a Content type
  let content: () -> Content

  var body: some View {
    self.content()
      .foregroundColor(Color.white)
      .padding()
      .background(Color.black)
      .cornerRadius(16)
      .transition(.move(edge: .top))
      .animation(.spring())
  }

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content
  }
}

/// # View protocol requires the body property
struct DateStack<Content: View>: View {
  /// # Stored property
  let day: Int
  let month: Int
  var year: String
  /// # Property which returns a func type
  let date: (Int, Int, String) -> Content

  init(day: Int, month: Int, year: String, @ViewBuilder date: @escaping (Int, Int, String) -> Content) {
    self.day = day
    self.month = month
    self.year = year
    /// # Need @scaping keyword
    self.date = date
  }

  var body: some View {
    self.date(day, month, year)
  }
}

/// # Custom container
/// Create any number of views inside a grid
/// The content inside the grid must also conform the View protocol
/// This is called Generics, you can provide any kind of content you want
/// but it must conform to the View protocol
/// <Content: View> is the only way to specify a Closure return value as a VIEW
struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  /// We dont know what Content is, but its closure return MUST conform the View Protocol
  /// content is  the return of the closure, whatever is returning from the { }
  /// # Closures cannot have Opaque return types (some kwd) 27/09/2021
  /// # View protocol can only be used as a GENERIC constrant because it
  /// # has ASSOCIATED type requirements, it must use SOME keyword
  let content: (Int, Int) -> Content

  // So is the body, hence some View
  var body: some View {
    VStack {
      /// We pass an id to let Swift know the # rows or columns might change
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<columns, id: \.self) { column in
            // Will generate each grid element
            /// calls content which returns a View
            content(row, column)
          }
        }
      }
    }
  }

  /// Create a custom initializer to use @ViewBuilder which allow us to
  /// Send in several views and have it form an implicit stack
  /// IT WILL ALSO WRAP EVERYTHING IN 1 VIEW, SO NO NEED TO MANUALLY WRAP THEM IN THE BODY
  init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
    self.rows = rows
    self.columns = columns
    /// This is why we need the @escaping tag
    self.content = content
  }
}

/// # Custom modifier
struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title2)
      .foregroundColor(.white)
      .padding()
      .background(Color.pink)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

struct Watermark: ViewModifier {
  var text: String

  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      content
      Text(text)
        .font(.caption)
        .foregroundColor(Color.white)
        .padding(5)
        .background(Color.black)
    }
  }
}

struct ProminentTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(Color.black)
  }
}

extension View {
  func titleStyle() -> some View {
    self.modifier(Title())
  }

  func watermarked(with text: String) -> some View {
    self.modifier(Watermark(text: text))
  }

  func prominentTitle() -> some View {
    self.modifier(ProminentTitle())
  }
}

struct CapsuleText: View {
  var text: String
  var body: some View {
    Text(text)
      .font(.title3)
      .padding()
      .background(Color.blue)
      .clipShape(Capsule())
  }
}

struct ContentView: View {
  @State private var notificationShown: Bool = false
  /// Swift REINVOKES the body propery whenever an @State variable changes
  @State private var useRedText = false
  /// Stored view
  let motto1 = Text("yesyes")
  /// Computed view
  var motto2: some View { Text("mr owo is in the house") }
  /// Cannot use them bound to a property
  // let btn = Button(motto1) {
  // print("owo")
  // }

  // This is due to having an associated type attached
  // some prefix is to let SwiftUI know we will return 1 View,
  // not which but that is A view not many
  // The code will decide which view to Return
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
        .watermarked(with: "yoo mr white")
        .edgesIgnoringSafeArea(.all)
      VStack {
        GridStack(rows: 4, columns: 4, content: {
          row, col in
          // IMPLICIT RETURN AS ITS THE ONLY ELEMENT
          Image(systemName: "\(row * 4 + col).circle")
          Text("R\(row) C\(col)")
            .foregroundColor(Color.white)
        })
        DateStack(day: 27, month: 9, year: "2021", date: { day, month, year in
          Text("\(day)/\(month)/\(year)")
        })
        Text("THIS IS DA WAE")
          .prominentTitle()
        Button("Hello World") {
          print(type(of: self.body))
          self.useRedText.toggle()
        }
        .background(Color.green)
        .foregroundColor(useRedText ? .red : .blue)
        .frame(width: 100, height: 50, alignment: .center)

        if self.notificationShown {
          NotificationViewFunc {
            Text("notification func")
          }
          NotificationView {
            Text("notification")
          }
        }
        Button("hi burdda") {
          self.notificationShown.toggle()
          print(type(of: self.body))
        }
        .frame(width: 200, height: 200, alignment: .center)
        .background(Color.red)
        Button("owowow") {
          print("xddd")
        }
        .padding()
        .background(Color.red)
        .padding()
        .background(Color.blue)
        .padding()
        .background(Color.green)
        HStack {
          Text("Pikachu")
          Text("Magikarp")
          Text("Squirtle")
          Text("Charmander")
          motto1
        }
        // Environment modifier
        .blur(radius: 1)
        CapsuleText(text: "jesse")
        Text("Pinkman")
          /// Calling custom modifier struct
          // .modifier(Title())
          /// Calling extended custom modifier from View
          .titleStyle()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
