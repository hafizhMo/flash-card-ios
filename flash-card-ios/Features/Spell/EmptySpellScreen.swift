//
//  EmptySpellScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI

struct EmptySpellScreen: View {
  @EnvironmentObject var router: Router
  
  var body: some View {
    VStack {
      Spacer()
      HStack {
        Text("No spell yet.")
        Button("Create a new one.") {
          router.navigate(to: .detailSpell(spell: Spell()))
        }
      }
      Spacer()
    }
  }
}
