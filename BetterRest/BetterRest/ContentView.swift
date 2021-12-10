import CoreML
import SwiftUI

struct SleepTimeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .foregroundColor(.blue)
  }
}

struct SleepTime: View {
  var text: String
  var idealTime: String
  var body: some View {
    HStack {
      Text(text)
      Text(idealTime)
        .modifier(SleepTimeModifier())
    }
  }
}

struct ContentView: View {
  @State private var wakeUp = defaultWakeTime
  @State private var sleepAmount: Double = 8.0
  @State private var coffeeAmount: Int = 1

  @State private var alertTitle: String = ""
  @State private var alertMessage: String = ""
  @State private var showingAlert: Bool = false

  var idealBedTime: String {
    calculateBedTime()
  }

  /// # Function to set initial time to 7AM
  /// # We’re accessing one property from inside another – Swift doesn’t know which order the properties will be created in, so this isn’t allowed.
  /// # Which means it belongs to the ContentView struct itself rather than a single instance of that struct. This in turn means defaultWakeTime can be read whenever we want, because it doesn’t rely on the existence of any other properties.
  static var defaultWakeTime: Date {
    /// # Create a new DateComponent
    var components = DateComponents()
    /// # Set the values
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? Date()
  }

  func calculateBedTime() -> String {
    /// # Select the components we will use [.hour, .minute] from the Date component
    let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    /// # Transform minutes and hours to seconds, because the train data is in seconds
    let minute = (components.minute ?? 0) * 60
    let hour = (components.hour ?? 0) * 60 * 60

    do {
      /// # SleepCalculator() is iOS 13, deprecated in iOS 16
      let model: SleepCalculator = try SleepCalculator(configuration: MLModelConfiguration())
      /// # Makes the model estimate how much sleep time you actually neeed, but in seconds
      let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
      /// # You can substract seconds from a Date and get a NEW Date
      let sleepTime = wakeUp - prediction.actualSleep
      /// # Create and config the formatter to make sleepTime readable
      let formatter = DateFormatter()
      formatter.timeStyle = .short
      /// # Format the sleepTime, make it a string, so its easier to understand
      /// # YOU CANNT MODIFY THE @STATE OF A VIEW WHILE ITS BEING RENDERED
      // alertTitle = "Your ideal bedtime is..."
      // alertMessage = formatter.string(from: sleepTime)
      return formatter.string(from: sleepTime)
    } catch {
      // alertTitle = "Error"
      // alertMessage = "Sorry, there was a problem calculating your bedtime"
      print(error)
      return "Error, problem calculating bedtime"
    }
    // showingAlert = true
  }

  var body: some View {
    NavigationView {
      Form {
        Group {
          Text("When you want to wake up")
          DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
        }
        Group {
          Text("Desired amount of sleep")
          Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
          }
        }
        Group {
          Picker("Daily coffee intake", selection: $coffeeAmount) {
            ForEach(1 ..< 10) { coffee in
              Text(coffee == 1 ? "1 cup" : "\(coffee) cups")
            }
          }
        }
        Section(header: Text("Ideal sleep time").font(.headline).textCase(.none)) {
          SleepTime(text: "Time is", idealTime: idealBedTime)
          // Text("Time is \(idealBedTime)")
        }
      }
      .font(.headline)
      .navigationBarTitle("BetterRest")

      /// # Will be deprecated
      /// # iOS 13, 14 & 15 support
      // .navigationBarItems(trailing:
      /// # You can also pass in the action directly
      // Button("Calculate") {
      //   self.calcuateBedTime()
      // }
      /// # This way you create a closure to call a function, why not call it directly?
      // Button(action: {
      //  self.calcuateBedTime()
      // }) {
      //  Text("Calculate")
      // }
      /// # If you invoke the func (), then action will expect to recieve a closure
      /// # as return from the func.
      // Button(action: calcuateBedTime()) {
      //  Text("Calculate")
      // }
      /// # Passing in the function
      // Button(action: calculateBedTime) {
      // Text("Calculate")
      //  .padding(10)
      //  .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
      //  .foregroundColor(.white)
      //  .clipShape(Capsule())
      // })
      /// # New iOS 15 version
      // .toolbar(content: {
      //  Button(action: calcuateBedTime) {
      //    Text("Calculate")
      //  }
      // })
    }
    /// # Will be deprecated
    /// # iOS 13, 14 & 15 support
    .alert(isPresented: $showingAlert) {
      Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
