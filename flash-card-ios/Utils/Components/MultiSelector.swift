//
//  MultiSelector.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 12/06/24.
//

import SwiftUI

struct MultiSelector<LabelView: View, Selectable: Identifiable & Hashable>: View {
  let label: LabelView
  let options: [Selectable]
  let optionToString: (Selectable) -> String
  
  var selected: Binding<Set<Selectable>>
  
  var body: some View {
    NavigationLink {
      MultiSelectionView(
        options: options,
        optionToString: optionToString,
        selected: selected
      )
    } label: {
      label
    }
  }
}

struct MultiSelectionView<Selectable: Identifiable & Hashable>: View {
  let options: [Selectable]
  let optionToString: (Selectable) -> String
  
  @Binding var selected: Set<Selectable>
  
  var body: some View {
    List {
      ForEach(options) { selectable in
        Button {
          toggleSelection(selectable: selectable)
        } label: {
          HStack {
            Text(optionToString(selectable)).foregroundColor(.black)
            Spacer()
            if selected.contains(where: { $0.id == selectable.id }) {
              Image(systemName: "checkmark").foregroundColor(.accentColor)
            }
          }
        }.tag(selectable.id)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private func toggleSelection(selectable: Selectable) {
    if let existingIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
      selected.remove(at: existingIndex)
    } else {
      selected.insert(selectable)
    }
  }
}
