//
//  ContentView.swift
//  StackColorButtonAlert
//
//  Created by Leonardo  on 25/09/21.
//

import SwiftUI

struct ContentView: View {
  @State private var showingAlert: Bool = false
  
  var body: some View {
    VStack {
      ZStack {
        // Only AngularGradient is visible due to the ZStack
        LinearGradient(gradient: Gradient(colors: [.purple, .white]), startPoint: .top, endPoint: .bottom)
        RadialGradient(gradient: Gradient(colors: [.red, .purple]), center: .center, startRadius: 20, endRadius: 400)
        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
          .edgesIgnoringSafeArea(.all)
        VStack(alignment: .leading) {
          Button("press me owo") {
            print("prssed")
          }
          .background(Color.green)
          Button(action: {
            // Trailing closure
            print("button was tappppped")
          }) {
            VStack {
              Text("tap meehh!!!")
                .foregroundColor(Color.red)
              Image(systemName: "pencil")
            }
          }
          .background(Color.yellow)
          HStack {
            Color.red.frame(width: 200, height: 200)
            Color.primary
            Color.secondary
            Color(red: 100, green: 255, blue: 0)
            VStack {
              Text("0,0")
              Text("1,0")
              Text("2,0")
            }
            .background(Color.red)
            VStack {
              Text("0,1")
              Text("1,1")
              Text("2,1")
            }
            .background(Color.blue)
            VStack {
              Text("0,2")
              Text("1,2")
              Text("2,2")
            }
            .background(Color.green)
          }
        }
        Button("PRESS ME FOR ALERT") {
          self.showingAlert = true
          print("pressed alert btn")
        }
        .background(Color.blue)
        .foregroundColor(Color.white)
        .alert(isPresented: $showingAlert) {
          Alert(title: Text("Hello this is alert"), message: Text("This is some detailed message"), dismissButton: .default(Text("OK")))
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
