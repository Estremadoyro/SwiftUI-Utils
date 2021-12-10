//
//  ExpensesListView.swift
//  iExpense
//
//  Created by Leonardo  on 13/11/21.
//

import SwiftUI

struct AmountModifier: ViewModifier {
  var amount: Double
  var amountColor: Color {
    switch amount {
      case 0...10:
        return Color.green
      case 11...100:
        return Color.black
      default:
        return Color.red
    }
  }

  func body(content: Content) -> some View {
    content
      .foregroundColor(amountColor)
  }
}

struct ExpensesListView: View {
  @ObservedObject var expenses: Expenses
  @State var expenseType: String

  func removeItems(at offsets: IndexSet) {
    let itemsIndices = createListWithIndexes(items: expenses.items)
    let itemsDictWithIndices = createDictWithIndexes(indices: itemsIndices, items: expenses.items)
    let grupedItemIndices = groupTuples(itemsTuple: itemsDictWithIndices, type: expenseType)
    offsets.forEach { offset in
      expenses.items.remove(at: grupedItemIndices[offset])
      print("4. Removed item")
      print(grupedItemIndices[offset])
    }
    // let dictionaryByType = groupDictionaries(itemsDict: itemsDictWithIndices, type: expenseType)
  }

  func groupTuples(itemsTuple: [(Int, ExpenseItem)], type: String) -> [Int] {
    var indicesList = [Int]()
    let groupedTuples = itemsTuple.filter { $1.type == type }
    groupedTuples.forEach { tuple in
      indicesList.append(tuple.0)
    }
    print("3. Filtered indices by \(expenseType)")
    print(indicesList)
    return indicesList
  }

  func createDictWithIndexes(indices: [Int], items: [ExpenseItem]) -> [(Int, ExpenseItem)] {
    var itemsTuple: [(Int, ExpenseItem)] = [(indices[0], items[0])]
    var indicesNoFirst = indices
    indicesNoFirst.removeFirst()
    indicesNoFirst.forEach { index in
      itemsTuple.append((index, items[index]))
    }
    print("2. List of tuples (Index, Item) created")
    print(itemsTuple)
    return itemsTuple
  }

  func createListWithIndexes(items: [ExpenseItem]) -> [Int] {
    var listIndexes = [Int]()
    items.indices.forEach { index in
      listIndexes.append(index)
    }
    print("1. List of indexes created")
    print(listIndexes)
    return listIndexes
  }

  func filterExpenseItems(items: [ExpenseItem], type: String) -> [ExpenseItem] {
    return items.filter { $0.type == type }
  }

  var body: some View {
    Section(header: Text("\(expenseType)")) {
      ForEach(filterExpenseItems(items: expenses.items, type: expenseType)) { item in
        HStack {
          VStack(alignment: .leading) {
            Text("\(item.name)")
              .font(.headline)
            Text("\(item.type)")
          }
          Spacer()
          Text("\(item.currency) \(item.amount, specifier: "%.2f")")
            .modifier(AmountModifier(amount: item.amount))
        }
      }
      .onDelete { index in
        self.removeItems(at: index)
      }
    }
  }
}
