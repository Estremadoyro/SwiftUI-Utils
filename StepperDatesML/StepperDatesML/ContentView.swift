//
//  ContentView.swift
//  StepperDatesML
//
//  Created by Leonardo  on 30/09/21.
//

import SwiftUI

struct ContentView: View {
  @State private var sleepAmount: Double = 8.0
  @State private var wakeUp = Date()

  var body: some View {
    var components = DateComponents()
    components.hour = 8
    components.minute = 0

    /// Returns an optional value
    let date = Calendar.current.date(from: components) ?? Date()

    /// # DatePicker is bound to a Date
    /// # We don't need all of Date's properties, so we need to specify which
    /// # ones we actually need
    let components2 = Calendar.current.dateComponents([.hour, .minute], from: date)
    /// We can still access all the properties but will be given 0 if not specified
    /// yet the ones requested must be unwrapped
    let hour = components2.hour ?? 10
    let minute = components2.minute ?? 10

    ///# Date ranges
    let now = Date()
    /// One day in seconds
    let tomorrow = Date().addingTimeInterval(86400)
    /// From this point in time on
    let range = now ... tomorrow
    
    ///# Date formaters
    /// let us convert a Date type into String
    let formatter = DateFormatter()
    /// Needed to specify the .timeStyle or it won't show nothing
    formatter.timeStyle = .short
    /// Style of date shown: .full, .long, .short, etc
    formatter.dateStyle = .long
    /// You can also specify the date format .dateFormat
    /// formatter.dateFormat =
    let dateString = formatter.string(from: date)
    /// Specify the return so it doesn't have to infer which one is it
    return VStack {
      Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
        /// # %.2f this one specifies 2 decimal values
        /// # %g this one rounds the number to int
        Text("\(sleepAmount, specifier: "%g") hours")
      }

      DatePicker("Please enter a date", selection: $wakeUp, in: range, displayedComponents: .hourAndMinute)
        .labelsHidden()
      Text("Hour: \(hour)")
      Text("Minute: \(minute)")
      HStack {
        Text("Full date:")
        Text("\(dateString)")
          .bold()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
