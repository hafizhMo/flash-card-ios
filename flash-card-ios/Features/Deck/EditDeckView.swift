//
//  EditDeckView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 11/06/24.
//

import SwiftUI
import SwiftData

struct EditDeckView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject private var router: Router
  @State private var name: String = ""

  @State private var selectedSpells: [Spell] = []
  @Query private var spells: [Spell]
  
  var body: some View {
    Form {
      // Deck section
      Section {
        TextField("Name of your magic book", text: $name)
      } header: {
        Text("Deck's Name 📚")
          .font(.system(size: 15, weight: .medium))
          .textCase(.none)
      }
      
      // Spell section
      Section {
        MultiSelector(label: Text("Select some spell"), options: spells, optionToString: { $0.name }, selected: $selectedSpells)
        
        ForEach(selectedSpells.sorted(by: { $0.name < $1.name }), id: \.self) { i in
          Text("• \(i.name)")
        }
        .onDelete(perform: deleteReferences)
        .onTapGesture {
          router.navigate(to: .editCard)
        }
        
        Button("Add a new spell") {
          router.navigate(to: .editCard)
        }
      } header: {
        HStack {
          Text("Spell(s) 🔮")
            .font(.system(size: 15, weight: .medium))
            .textCase(.none)
          Spacer()
          Text("Total: \(selectedSpells.count)")
            .font(.system(size: 15, weight: .regular))
            .textCase(.none)
        }
      } footer: {
        Text("Info: delete on swipe a list to left only remove the references")
          .padding(.bottom)
      }
      
    }
    .navigationTitle("Detail Deck")
    .navigationBarBackButtonHidden(true)
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button("Back", systemImage: "chevron.left") {
          router.navigateBack()
        }
      }
      
      ToolbarItem(placement: .topBarTrailing) {
        if name.isEmpty {
          Button("Save", action: saveDeck)
        } else {
          Button("Edit", action: saveDeck)
        }
      }
    }
  }
  
  private func addCard() {
    router.navigate(to: .editCard)
  }
  
  private func saveDeck() {
    let deck = Deck(name: name)
    deck.spells.append(contentsOf: Array(selectedSpells))
    modelContext.insert(deck)
    name = ""
    selectedSpells = []
  }
  
  private func deleteReferences(_ indexSet: IndexSet) {
    
  }
}

#Preview {
  EditDeckView()
}
