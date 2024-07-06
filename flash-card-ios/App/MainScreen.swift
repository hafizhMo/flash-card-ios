//
//  MainView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct MainScreen: View {
  @Environment(\.modelContext) private var modelContext
  
  @State var path = NavigationPath()
  @Query private var allDeck: [Deck]
  @Query private var allSpell: [Spell]
  
  @AppStorage("isFirstTime") var isFirstTime = true
  @AppStorage("selectedDeck") var selectedDeck = ""
  
  var body: some View {
    NavigationStack(path: $path) {
      VStack {
        if allDeck.first != nil {
          HomeScreen(path: $path)
        } else {
          EmptyDeckScreen(path: $path)
        }
      }
      .padding()
      .navigationDestination(for: Spell.self) { spell in
        DetailSpellScreen(spell: spell, path: $path)
      }
      .navigationDestination(for: Deck.self) { deck in
        DetailDeckScreen(deck: deck, path: $path)
      }
      .onAppear {
        if isFirstTime && selectedDeck.isEmpty {
          createDummy()
          selectedDeck = "dummy"
          isFirstTime = false
        }
      }
    }
  }
  
  private func createDummy() {
    let spell1 = Spell(name: "1", detail: "satu", notes: "")
    let spell2 = Spell(name: "2", detail: "dua", notes: "")
    let spell3 = Spell(name: "3", detail: "tiga", notes: "")
    
    let deck = Deck(name: "dummy", spells: [spell1, spell2, spell3])
    modelContext.insert(deck)
  }
}
