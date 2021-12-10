//
//  File.swift
//  StateSheetDelete
//
//  Created by Leonardo  on 9/11/21.
//

import SwiftUI

/// # Codable protocol, allows the struct to be encoded into a JSON format
struct Student: Codable {
  var firstName: String = "Leonardo"
  var lastName: String = "Estremadoyro"
}

struct EncoderView: View {
  @State private var student = Student()

  var body: some View {
    VStack {
      Button("Save user") {
        let encoder = JSONEncoder()
        /// # Can return an error, so it needs a try?
        if let data: Data = try? encoder.encode(self.student) {
          UserDefaults.standard.set(data, forKey: "UserData")
        }
      }
      .frame(width: 100, height: 50)
      .foregroundColor(Color.white)
      .background(Color.blue.cornerRadius(25))
      .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 2))

      Text("\(student.firstName) \(student.lastName)")
      TextField("First name", text: $student.firstName)
        .padding()
      TextField("Last name", text: $student.lastName)
        .padding()
    }
  }
}
