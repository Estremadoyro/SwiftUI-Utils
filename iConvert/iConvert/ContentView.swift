//
//  ContentView.swift
//  iConvert
//
//  Created by Leonardo  on 24/09/21.
//

import SwiftUI

struct ContentView: View {
  @State private var inputNumber: String = ""
  @State private var inputUnit: Int = 0
  @State private var outputUnit: Int = 1

  let units: [String] = ["°C", "°F", "°K"]
  let measurementUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]

  var convertedTemperature: Double {
    let parsed = Double(inputNumber) ?? 0
    let inputTemperature = Measurement(value: parsed, unit: measurementUnits[inputUnit])
    let outputTemperature = inputTemperature.converted(to: measurementUnits[outputUnit]).value
    return outputTemperature
  }

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("From").textCase(.none)) {
          Picker("Input unit", selection: $inputUnit) {
            ForEach(0 ..< units.count) {
              Text(self.units[$0])
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          TextField("Temperature", text: $inputNumber)
            .keyboardType(.decimalPad)
        }
        Section(header: Text("To").textCase(.none)) {
          Picker("Output unit", selection: $outputUnit) {
            ForEach(0 ..< units.count) {
              Text(self.units[$0])
            }
          }
          .pickerStyle(SegmentedPickerStyle())
          Text("\(self.units[outputUnit]) \(self.convertedTemperature, specifier: "%.1f")")
        }
      }
      .navigationTitle("iConvert")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
