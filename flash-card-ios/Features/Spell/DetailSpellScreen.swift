//
//  DetailSpellScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

enum DetailState: String {
  case create = "Create"
  case edit = "Edit"
  case detail = "Detail"
}

struct DetailSpellScreen: View {
  @Environment(\.modelContext) private var modelContext
  
  @Bindable var spell: Spell
  @Binding var path : NavigationPath
  
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
      
      HStack {
        Spacer()
        Button("Delete", role: .destructive) {
          modelContext.delete(spell)
          path.removeLast()
        }
        Spacer()
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
