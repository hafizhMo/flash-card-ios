//
//  HomeScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 30/06/24.
//

import SwiftUI

enum CardState {
  case idle
  case reset
  case shuffle
}

struct HomeScreen: View {
  @Bindable var deck: Deck
  @Binding var path : NavigationPath
  @State private var selected: Deck = Deck()
  @State private var state: CardState = .idle
  
  var body: some View {
    VStack {
      Spacer()
      CardComponent(spells: $selected.spells, state: $state)
      Spacer()
      
      Button("shuffle") {
        state = .shuffle
        withAnimation(.easeInOut(duration: 0.4)){
          selected.spells.shuffle()
        }
      }
      
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
      SelectDeckScreen(selected: $selected, state: $state, path: $path)
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

