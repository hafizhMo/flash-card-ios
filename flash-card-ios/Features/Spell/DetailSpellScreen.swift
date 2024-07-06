//
//  DetailSpellScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct DetailSpellScreen: View {
  @Environment(\.modelContext) var modelContext
  @EnvironmentObject var router: Router
  
  @Bindable var spell: Spell
  
  @State private var state: DetailState = .detail
  @State private var name = ""
  @State private var detail = ""
  @State private var notes = ""
  
  var body: some View {
    Form {
      Section {
        TextField("A Name", text: $name)
          .disabled(state == .detail)
        TextField("Meaning of the Name", text: $detail)
          .disabled(state == .detail)
      }
      
      Section {
        TextField("Explanation of the", text: $notes, axis: .vertical)
          .lineLimit(5, reservesSpace: true)
          .disabled(state == .detail)
      }
      
      if state == .edit {
        HStack {
          Spacer()
          Button("Delete", role: .destructive) {
            modelContext.delete(spell)
            router.navigateBack()
          }
          Spacer()
        }
      }
    }
    .navigationTitle("\(state.rawValue) Spell")
    .onAppear(perform: loadSpell)
    .toolbar {
      Button(action: {
        if name.isEmpty && detail.isEmpty {
          return
        }
        
        switch state {
        case .create:
          createSpell()
        case .edit:
          editSpell()
        case .detail:
          state = .edit
        }
      }, label: {
        Text(state != .detail ? "Save" : "Edit")
      })
    }
  }
  
  private func createSpell() {
    let newSpell = Spell(name: name, detail: detail, notes: notes)
    modelContext.insert(newSpell)
    
    name = ""
    detail = ""
    notes = ""
  }
  
  private func editSpell() {
    spell.name = name
    spell.detail = detail
    spell.notes = notes
    state = .detail
  }
  
  private func loadSpell() {
    name = spell.name
    detail = spell.detail
    notes = spell.notes
    if name.isEmpty && detail.isEmpty {
      state = .create
    }
  }
}
