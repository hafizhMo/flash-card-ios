//
//  SelectDeckScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 30/06/24.
//

import SwiftUI
import SwiftData

struct SelectDeckScreen: View {
  @EnvironmentObject var router: Router
  
  @Query private var allDeck: [Deck]
  
  @AppStorage("selectedDeck") private var selectedDeck = ""
  
  var body: some View {
    List {
      ForEach(allDeck) { deck in
        HStack {
          VStack(alignment: .leading, spacing: 8) {
            Text(deck.name)
              .foregroundColor(.primaryLabel)
            Text("total: \(deck.spells.count) spell(s)")
              .font(.system(size: 12))
              .foregroundColor(.secondaryLabel)
          }
          
          Spacer()
          
          if selectedDeck == deck.name {
            Image(systemName: "checkmark").foregroundColor(.accentColor)
          }
        }
        .background(Color.primaryBackground)
        .onTapGesture {
          selectedDeck = deck.name
          router.navigateBack()
        }
        
      }
    }
  }
}

