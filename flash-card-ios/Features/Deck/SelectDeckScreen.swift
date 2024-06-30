//
//  SelectDeckScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 30/06/24.
//

import SwiftUI
import SwiftData

struct SelectDeckScreen: View {
  @Query private var allDeck: [Deck]
  
  @Binding var selected: Deck
  @Binding var state: CardState
  @Binding var path : NavigationPath
  
  var body: some View {
    List {
      ForEach(allDeck) { deck in
        HStack {
          Text(deck.name)
          Spacer()
          if selected.name == deck.name {
            Image(systemName: "checkmark").foregroundColor(.accentColor)
          }
        }
        .onTapGesture {
          state = .reset
          selected = deck
          path.removeLast()
        }
      }
    }
  }
}

