//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Leonardo  on 9/11/21.
//

import Foundation

/// # Identifiable, types that will ALWAYS be unique, it required an id property
/// # Encodable, struct can now be encoded
/// # Decodable, struct can now be decoded
///  # Codable combines Encodable & Encodable
struct ExpenseItem: Identifiable, Codable {
  /// # It has to be a var because we are invoking the UUID() directly into it
  var id = UUID()
  let name: String
  let type: String
  let amount: Double
  let currency: String
}
