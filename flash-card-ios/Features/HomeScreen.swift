//
//  HomeScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 30/06/24.
//

import SwiftUI

struct HomeScreen: View {
  @Bindable var deck: Deck
  @Binding var path : NavigationPath
  @State private var selected: Deck = Deck()
  @State private var reset = false
  
  var body: some View {
    VStack {
      Spacer()
      CardComponent(spells: $selected.spells, reset: $reset)
      Spacer()
      
      Button("Pick another deck") {
        path.append("pick")
      }
      
      Button("Manage deck") {
        path.append(0)
      }
      
      Button("Manage spell") {
        path.append(1)
      }
    }
    .navigationDestination(for: String.self) { _ in
      SelectDeckScreen(selected: $selected, reset: $reset, path: $path)
    }
    .navigationDestination(for: Int.self, destination: { code in
      if code == 0 {
        AllDeckScreen(path: $path)
      }
      
      if code == 1{
        AllSpellScreen(path: $path)
      }
    })
    .onAppear {
      if selected.name.isEmpty {
        selected = deck
      }
    }
  }
}

