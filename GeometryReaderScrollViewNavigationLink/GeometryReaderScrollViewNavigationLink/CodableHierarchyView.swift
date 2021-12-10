//
//  CodableHierarchyView.swift
//  GeometryReaderScrollViewNavigationLink
//
//  Created by Leonardo  on 14/11/21.
//

import SwiftUI

struct Chapter: Codable {
  let ch_name: String
  let ch_number: String
}

struct Volume: Codable {
  let vol_number: String
  let vol_n_chapters: String
  let chapters: [Chapter]
}

struct Manga: Codable {
  let title: String
  let author: String
  let volumes: [Volume]
}

struct CodableHierarchyView: View {
  var body: some View {
    Button("Decode JSON") {
      let input = """
      {
        "title": "Dr. Stone",
        "author": "Riichiro Inagaki",
        "volumes": [
          {
            "vol_number": "1",
            "vol_n_chapters": "9",
            "chapters": [
              {
                "ch_name": "Stone World",
                "ch_number": "1"
              }
            ]
          }
        ]
      }
      """
      let data = Data(input.utf8)
      if let manga = try? JSONDecoder().decode(Manga.self, from: data) {
        print(manga)
      } else {
        print("error :(")
      }
    }
  }
}
