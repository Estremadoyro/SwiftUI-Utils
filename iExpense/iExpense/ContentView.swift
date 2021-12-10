//
//  ContentView.swift
//  iExpense
//
//  Created by Leonardo  on 9/11/21.
//

import SwiftUI

struct ContentView: View {
  @StateObject var expenses = Expenses()
  @State var showingAddExpenseView: Bool = false
  let types: [String] = ["Personal", "Business"]

  func findFirstElement(items: [ExpenseItem], type: String) -> Int {
    if let personal = items.firstIndex(where: { $0.type == type }) {
      return personal
    }
    return 0
  }

  var body: some View {
    NavigationView {
      List {
        /// # id parameter is no longer needed as expenses items are already unique (@Identifiable)
        ForEach(types, id: \.self) { expenseType in
          ExpensesListView(expenses: expenses, expenseType: expenseType)
        }
      }
      .navigationTitle("iExpense")
      .toolbar {
        Button(action: {
          self.showingAddExpenseView = true
        }) {
          Image(systemName: "plus")
        }
      }
    }
    .sheet(isPresented: $showingAddExpenseView) {
      AddView(expenses: expenses)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
