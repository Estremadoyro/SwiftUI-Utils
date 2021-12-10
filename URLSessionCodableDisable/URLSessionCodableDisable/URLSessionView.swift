//
//  URLSessionView.swift
//  URLSessionCodableDisable
//
//  Created by Leonardo  on 9/12/21.
//

import SwiftUI

struct Result: Codable {
  var trackId: Int
  var trackName: String
  var collectionName: String
}

struct Response: Codable {
  var results: [Result]
}

struct URLSessionView: View {
  @State private var results = [Result]()
  /// # `Takes a closure` which requires an arg. of type `[Result]` and returns `Void`
  /// # `@escaping` means the closure execution is being `escapted`, this it is preserved in memory until it gets to run
  /// # `@escaping` the closure will `exist` even `after` the execution is finished, until the `closure gets executed`
  func loadData(completion: @escaping ([Result]) -> ()) {
    guard let url = URL(string: "https://itunes.apple.com/search?term=maroon+5&entitry=song") else {
      print("Invalid URL :(")
      return
    }
    /// # `data`     -> Data returned by the server
    /// # `response` -> Contains the metadata, `http headers, https request` HTTPURLResponse obj.
    /// # `error`    -> Error obj. indicates why the request failed
    URLSession.shared.dataTask(with: url) { data, _, _ in
      if let fetchedData = data {
        print("data fetched")
        print(fetchedData)
        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: fetchedData) {
          print(decodedResponse)
          /// # `async` Invoke this `closure`, without waiting for it to finish
          DispatchQueue.main.async {
            /// # It runs `self.results = data`
            /// # Where `data` is the `decodedResponse.results`
            completion(decodedResponse.results)
            /// # Settings `self.results` also works, `without closures`
//            self.results = decodedResponse.results
          }
          return
        }
        print("failed to decode response")
        return
      }
      print("failed to fetch data")
    }
    /// # After `created a TASK` it must be called with `resume()` method
    .resume()
  }

  var body: some View {
    List(results, id: \.trackId) { item in
      VStack(alignment: .leading) {
        Text(item.trackName)
          .font(.headline)
        Text(item.collectionName)
      }
    }
    /// # `iOS 15 ONLY fk`
    /// # `.onAppear {}` can't handle `async` functions
    /// # `Unless` given the `async` closure
    /// # `await` is necessary in order to call an `async` function
    /// # `------------`
    /// # `iOS 13`
    .onAppear {
      /// # Takes a `data` parameter of type `[Result]`
      let setFetchedData = { data in
        self.results = data
      }
      self.loadData(completion: setFetchedData)
      /// # `Trailing Closure`
//      self.loadData(completion: { data in
//        self.results = data
//      })
    }
  }
}
