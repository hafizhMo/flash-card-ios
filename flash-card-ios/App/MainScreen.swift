//
//  MainView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct MainScreen: View {
  @State var path = NavigationPath()
  @Query private var allDeck: [Deck]
  @Query private var allSpell: [Spell]
  @State private var selected = 0
  
  var body: some View {
    NavigationStack(path: $path) {
      VStack {
        Picker("Content", selection: $selected) {
          Text("All Deck").tag(0)
          Text("All Spell").tag(1)
        }
        .pickerStyle(.segmented)
        
        if selected == 0 {
          if allDeck.first != nil {
            AllDeckScreen(path: $path)
          } else {
            EmptyDeckScreen(path: $path)
          }
        } else {
          if allSpell.first != nil {
            AllSpellScreen(path: $path)
          } else {
            EmptySpellScreen(path: $path)
          }
        }
      }
      .padding()
      .navigationDestination(for: Spell.self) { spell in
        DetailSpellScreen(spell: spell, path: $path)
      }
      .navigationDestination(for: Deck.self) { deck in
        DetailDeckScreen(deck: deck, path: $path)
      }
    }
  }
}
