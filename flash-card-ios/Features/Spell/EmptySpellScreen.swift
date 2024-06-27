//
//  EmptySpellScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI

struct EmptySpellScreen: View {
  @Binding var path : NavigationPath
  var body: some View {
    HStack {
      Text("No spell yet.")
      Button("Create a new one.") {
        path.append(Spell())
      }
    }
  }
}
