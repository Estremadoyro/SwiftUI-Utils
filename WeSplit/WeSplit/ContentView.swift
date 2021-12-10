//
//  ContentView.swift
//  WeSplit
//
//  Created by Leonardo  on 24/09/21.
//

import SwiftUI

// ## ## FOREACH COUNTS FROM 0 !!!! ## ##
struct ContentView: View {
  @State private var checkAmount: String = "0"
  @State private var numberOfPeople: Int = 2
  @State private var tipPercentage: Int = 2

  var tipPercentages: [Int] = [10, 15, 20, 25, 0]

  var parseOrderAmount: Double {
    return Double(self.checkAmount) ?? 0
  }

  var tipAmount: Double {
    // Try to parse to Double, but it throws an error send 0
    let orderAmount = self.parseOrderAmount
    let tipSelection = Double(tipPercentages[tipPercentage])
    let tipValue = orderAmount * (tipSelection / 100)
    return tipValue
  }
  
  var totalWithTip: Double {
    let tipValue = self.tipAmount
    let grandTotal = self.parseOrderAmount + tipValue
    return grandTotal
  }

  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let amountPerPerson = totalWithTip / peopleCount
    return amountPerPerson
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
          Picker("Number of people", selection: $numberOfPeople, content: {
            // Remember this starts @ 0
            ForEach(2 ..< 100, content: {
              Text("\($0) people")
            })
          })
        }
        Section(header: Text("How much tip you want to leave? Tip: $ \(tipAmount, specifier: "%.2f")").textCase(.none)) {
          Picker("Tip percentage", selection: $tipPercentage, content: {
            ForEach(0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0]) %")
            }
          })
            .pickerStyle(SegmentedPickerStyle())
        }
        Section(header: Text("Total with tip").textCase(.none)) {
          Text("$ \(totalWithTip, specifier: "%.2f")")
            .foregroundColor(tipPercentages[tipPercentage] > 0 ? Color.black : Color.red)
        }
        Section(header: Text("Total per person").textCase(.none)) {
          Text("$ \(totalPerPerson, specifier: "%.2f")")
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
