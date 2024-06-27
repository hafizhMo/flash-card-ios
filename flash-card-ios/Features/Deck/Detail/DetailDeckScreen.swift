//
//  DetailDeckScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI

struct DetailDeckScreen: View {
  @Environment(\.modelContext) private var modelContext
  
  @Bindable var deck: Deck
  @Binding var path : NavigationPath
  
  @State private var state: DetailState = .detail
  @State private var name = ""
  @State private var selectedSpells: Set<Spell> = []
  
  var body: some View {
    Form {
      Section {
        TextField("A Name", text: $name)
          .disabled(state == .detail)
      }
      
      Section("Spell(s)") {
        if state != .detail {
          NavigationLink("Select some spell") {
            SelectSpellView(selectedSpells: $selectedSpells)
          }
        } else {
          if selectedSpells.isEmpty {
            HStack {
              Spacer()
              Text("No spell yet.").foregroundStyle(.tertiary)
              Spacer()
            }
          }
        }
        
        ForEach(selectedSpells.sorted(by: { $0.name > $1.name }), id:\.self) { spell in
          Text(spell.name)
        }
      }
      
      if state == .edit {
        HStack {
          Spacer()
          Button("Delete", role: .destructive) {
            modelContext.delete(deck)
            path.removeLast()
          }
          Spacer()
        }
      }
    }
    .navigationTitle("\(state.rawValue) Deck")
    .onAppear(perform: loadDeck)
    .toolbar {
      Button(action: {
        if name.isEmpty {
          return
        }
        
        switch state {
        case .create:
          createDeck()
        case .edit:
          editDeck()
        case .detail:
          state = .edit
        }
      }, label: {
        Text(state != .detail ? "Save" : "Edit")
      })
    }
  }
  
  private func createDeck() {
    let newDeck = Deck(name: name, spells: Array(selectedSpells))
    modelContext.insert(newDeck)
    
    name = ""
    selectedSpells = []
    deck.spells = []
  }
  
  private func editDeck() {
    deck.name = name
    deck.spells = Array(selectedSpells)
    state = .detail
  }
  
  private func loadDeck() {
    if name.isEmpty {
      name = deck.name
    }
    
    if selectedSpells.isEmpty {
      for (_, spell) in deck.spells.enumerated() {
        selectedSpells.insert(spell)
      }
    }

    if name.isEmpty {
      state = .create
    }
  }
}
