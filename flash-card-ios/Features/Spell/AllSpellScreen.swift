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
  @Query private var allSpell: [Spell]
  
  @Binding var path : NavigationPath
  
  var body: some View {
    VStack(spacing:0) {
      List {
        ForEach(allSpell) { spell in
          NavigationLink(spell.name, value: spell)
        }
        .onDelete(perform: deleteSpell)
      }
      
      Button("Create another spell") {
        path.append(Spell())
      }
      .padding()
    }
    .navigationTitle("All Spell")
  }
  
  func deleteSpell(at offsets: IndexSet) {
    for offset in offsets {
      let spell = allSpell[offset]
      modelContext.delete(spell)
    }
  }
}

