//
//  EditCardView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 11/06/24.
//

import SwiftUI

struct EditCardView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject private var router: Router
  @State private var name: String = ""
  @State private var detail: String = ""
  @State private var notes: String = ""
  
  var body: some View {
    Form {
      Section {
        TextField("Your magic spell", text: $name)
        TextField("What the spell for?", text: $detail, axis: .vertical)
      } header: {
        Text("About spell 🪄")
          .font(.system(size: 15, weight: .medium))
          .textCase(.none)
      }
      
      Section {
        TextField("Explain your spell about..", text: $notes, axis: .vertical)
          .lineLimit(10, reservesSpace: true)
        
        HStack {
          Spacer()
          Button("Upload Images", systemImage: "photo.badge.plus", action: uploadImage)
          Spacer()
        }
        
        
      } header: {
        Text("Magic Notes ✨")
          .font(.system(size: 15, weight: .medium))
          .textCase(.none)
      } footer: {
        Label("You can mention example case, description, even images or anything that can help you to understand the spell", systemImage: "info.circle")
      }

      Section {
        List {
          ForEach(1...4, id: \.self) { i in
            Text("• Deck number \(i)")
          }
        }
      } header: {
        Text("Mentioned on:")
          .font(.system(size: 15, weight: .medium))
          .textCase(.none)
      }

    }
    .navigationTitle("Detail Card")
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
          Button("Save", action: addSpell)
        } else {
          Button("Edit", action: addSpell)
        }
      }
    }
    
  }
  
  private func uploadImage() {
    
  }
  
  private func addSpell() {
    let spell = Spell(name: name, detail: detail, notes: notes)
    modelContext.insert(spell)
    name = ""
    detail = ""
    notes = ""
  }
}

#Preview {
  EditCardView()
}
