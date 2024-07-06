//
//  AllSpellScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct AllSpellScreen: View {
  @Environment(\.modelContext) var modelContext
  @EnvironmentObject var router: Router
  
  @Query private var allSpell: [Spell]
  
  var body: some View {
    VStack(spacing:0) {
      List {
        ForEach(allSpell) { spell in
          Button {
            router.navigate(to: .detailSpell(spell: spell))
          } label: { Text(spell.name) }
        }.onDelete(perform: deleteSpell)
      }
      
      Button("Create another spell") {
        router.navigate(to: .detailSpell(spell: Spell()))
      }
      .padding()
    }
  }
  
  func deleteSpell(at offsets: IndexSet) {
    for offset in offsets {
      let spell = allSpell[offset]
      modelContext.delete(spell)
    }
  }
}

