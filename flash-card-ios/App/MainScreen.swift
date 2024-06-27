//
//  MainView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI
import SwiftData

struct MainScreen: View {
  @State var path = NavigationPath()
  @Query private var allSpell: [Spell]
  
  var body: some View {
    NavigationStack(path: $path) {
      VStack {
        if allSpell.first != nil {
          AllSpellScreen(path: $path)
        } else {
          EmptySpellScreen(path: $path)
        }
      }
      .navigationDestination(for: Spell.self) { spell in
        DetailSpellScreen(spell: spell, path: $path)
      }
    }
  }
}
