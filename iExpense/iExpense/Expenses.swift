//
//  Expenses.swift
//  iExpense
//
//  Created by Leonardo  on 9/11/21.
//

import Foundation

/// # Observable object, so it let other types know when its has changed
class Expenses: ObservableObject {
  /// # Announces changes from a property
  @Published var items = [ExpenseItem]() {
    /// # Whenever an item is updated or added, we want to save it to the UserDefaults
    didSet {
      /// # Writing data to the UserDefaults
      if let encoded = try? JSONEncoder().encode(items) {
        UserDefaults.standard.set(encoded, forKey: "Items")
      }
    }
  }

  /// # Custom initializer to load items from the UserDefaults
  init() {
    if let savedItems = UserDefaults.standard.data(forKey: "Items") {
      /// # [ExpenseItem].self -> Specifies its all the struct properties
      if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
        self.items = decodedItems
        return
      }
    }
    /// # If items can't be loaded, then set them to empty []
    self.items = []
  }
}
