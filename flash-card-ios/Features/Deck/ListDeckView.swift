//
//  ListDeckView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 14/06/24.
//

import SwiftUI
import SwiftData

struct ListDeckView: View {
  @Query private var decks: [Deck]
  @EnvironmentObject private var router: Router
  
  var body: some View {
    List {
      ForEach(decks, id:\.self) { deck in
        VStack(alignment: .leading) {
          Text(deck.name).bold()
          
          if deck.spells.count > 0 {
            Text(deck.spells.map({ $0.name }).formatted(.list(type: .and)))
          }
        }
      }
      .onTapGesture {
        router.navigate(to: .editDeck)
      }
    }
  }
}
