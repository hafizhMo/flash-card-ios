//
//  SelectSpellView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct SelectSpellView: View {
  
  @Binding var selectedSpells: Set<Spell>
  @Query private var allSpell: [Spell]
  
  var body: some View {
    List {
      ForEach(allSpell) { spell in
        Button {
          toggleSelection(spell: spell)
        } label: {
          HStack {
            Text(spell.name)
            Spacer()
            if selectedSpells.contains(where: { $0.id == spell.id }) {
              Image(systemName: "checkmark").foregroundColor(.accentColor)
            }
          }
        }.tag(spell.id)
      }
    }
  }
  
  private func toggleSelection(spell: Spell) {
    if let existingIndex = selectedSpells.firstIndex(where: { $0.id == spell.id }) {
      selectedSpells.remove(at: existingIndex)
    } else {
      selectedSpells.insert(spell)
    }
  }
}
