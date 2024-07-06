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
  
  @Binding var state: CardState
  @Binding var path : NavigationPath
  
  @AppStorage("selectedDeck") var selectedDeck = ""
  
  var body: some View {
    List {
      ForEach(allDeck) { deck in
        HStack {
          Text(deck.name)
          Spacer()
          if selectedDeck == deck.name {
            Image(systemName: "checkmark").foregroundColor(.accentColor)
          }
        }
        .background(Color.primaryBackground)
        .onTapGesture {
          state = .reset
          selectedDeck = deck.name
          path.removeLast()
        }
      }
    }
  }
}

