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
  
  var body: some View {
    Form {
      Section {
        TextField("A Name", text: $name)
          .disabled(state == .detail)
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
    let newDeck = Deck(name: name)
    modelContext.insert(newDeck)
    
    name = ""
  }
  
  private func editDeck() {
    deck.name = name
    state = .detail
  }
  
  private func loadDeck() {
    name = deck.name
    if name.isEmpty {
      state = .create
    }
  }
}
