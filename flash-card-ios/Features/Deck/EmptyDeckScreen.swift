//
//  EmptyDeckScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 27/06/24.
//

import SwiftUI

struct EmptyDeckScreen: View {
  @Binding var path : NavigationPath
  var body: some View {
    VStack {
      Spacer()
      HStack {
        Text("No deck yet.")
        Button("Create a new one.") {
          path.append(Deck())
        }
      }
      Spacer()
    }
  }
}
