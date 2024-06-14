//
//  EditDeckView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 11/06/24.
//

import SwiftUI

struct Goal: Hashable, Identifiable {
  var name: String
  var id: String { name }
}

struct EditDeckView: View {
  @EnvironmentObject private var router: Router
  @State private var name: String = ""
  
  let allGoals: [Goal] = [Goal(name: "Learn Japanese"), Goal(name: "Learn SwiftUI"), Goal(name: "Learn Serverless with Swift")]
  @State private var selectedCards: Set<Goal> = []
  
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
        MultiSelector(label: Text("Select some spell"), options: allGoals, optionToString: { $0.name }, selected: $selectedCards)
        
        ForEach(selectedCards.sorted(by: { $0.name < $1.name }), id: \.self) { i in
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
          Text("Total: \(selectedCards.count)")
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
    
  }
  
  private func deleteReferences(_ indexSet: IndexSet) {
    
  }
}

#Preview {
  EditDeckView()
}
