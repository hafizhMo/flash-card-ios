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
  @Query private var allDeck: [Deck]
  
  @Binding var path : NavigationPath
  
  var body: some View {
    VStack(spacing:0) {
      List {
        ForEach(allDeck) { deck in
          NavigationLink(deck.name, value: deck)
        }
        .onDelete(perform: deleteDeck)
      }
      
      Button("Create another deck") {
        path.append(Deck())
      }
      .padding()
    }
  }
  
  func deleteDeck(at offsets: IndexSet) {
    for offset in offsets {
      let deck = allDeck[offset]
      modelContext.delete(deck)
    }
  }
}
