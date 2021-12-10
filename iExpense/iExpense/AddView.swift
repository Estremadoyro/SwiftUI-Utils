//
//  AddView.swift
//  iExpense
//
//  Created by Leonardo  on 9/11/21.
//

import SwiftUI

struct AddView: View {
  /// # Watches announced changes (@Published) from an Observable (Protocol) object
  @ObservedObject var expenses: Expenses
  /// # Catches the sheet current show state @Environment(\.presentationMode)
  @Environment(\.presentationMode) var showingAddExpenseView

  @State private var name: String = ""
  @State private var type: String = "Personal"
  @State private var amount: Double = 0.0
  @State private var currency: String = "USD"

  let currencies: [String] = ["USD", "PEN", "EUR", "JPN"]
  let types: [String] = ["Business", "Personal"]

  static var numberFormatter: NumberFormatter {
    let f = NumberFormatter()
    f.numberStyle = .currency
    f.currencyCode = "USD"
    return f
  }

  var body: some View {
    NavigationView {
      Form {
        TextField("Name", text: $name)
        Picker("Type", selection: $type) {
          ForEach(types, id: \.self) {
            Text($0)
          }
        }
        TextField("Amount", value: $amount, formatter: AddView.numberFormatter)
          .keyboardType(.decimalPad)
          .onChange(of: currency) { newCurrency in
            print(newCurrency)
            AddView.numberFormatter.currencyCode = newCurrency
          }
        Picker("Currency", selection: $currency) {
          ForEach(currencies, id: \.self) {
            Text("\($0)")
          }
        }
      }
      .navigationTitle("Add new expense")
      .toolbar {
        Button("Save") {
          let item = ExpenseItem(name: self.name, type: self.type, amount: self.amount, currency: self.currency)
          if item.name == "", item.amount == 0.0 {
            return
          }
          expenses.items.append(item)
          /// # Dismisses the sheet inside the wrappedValue property
          self.showingAddExpenseView.wrappedValue.dismiss()
        }
      }
    }
  }
}
