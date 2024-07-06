//
//  MainView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct MainScreen: View {
  @Environment(\.modelContext) var modelContext
  @EnvironmentObject var router: Router
  
  @AppStorage("isFirstTime") private var isFirstTime = true
  @AppStorage("selectedDeck") private var selectedDeck = ""
  
  @Query private var allDeck: [Deck]
  
  var body: some View {
    NavigationStack(path: $router.navPath) {
      VStack {
        if allDeck.first != nil {
          HomeScreen()
        } else {
          EmptyDeckScreen()
        }
      }
      .navigationDestination(for: Router.Destination.self) { destination in
        switch destination {
        case .selectDeck:
          SelectDeckScreen()
        case .detailDeck(let deck):
          DetailDeckScreen(deck: deck)
        case .detailSpell(let spell):
          DetailSpellScreen(spell: spell)
        case .manage:
          ManageScreen()
        }
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
