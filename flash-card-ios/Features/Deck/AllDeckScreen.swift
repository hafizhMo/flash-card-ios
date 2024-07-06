//
//  AllDeckScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct AllDeckScreen: View {
  @Environment(\.modelContext) var modelContext
  @EnvironmentObject var router: Router
  
  @Query private var allDeck: [Deck]
  
  var body: some View {
    VStack(spacing:0) {
      List {
        ForEach(allDeck) { deck in
          Button {
            router.navigate(to: .detailDeck(deck: deck))
          } label: { Text(deck.name) }
        }.onDelete(perform: deleteDeck)
      }
      
      Button("Create another deck") {
        router.navigate(to: .detailDeck(deck: Deck()))
      }.padding()
    }
  }
  
  private func deleteDeck(at offsets: IndexSet) {
    for offset in offsets {
      let deck = allDeck[offset]
      modelContext.delete(deck)
    }
  }
  
}
