//
//  flash_card_iosApp.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 11/06/24.
//

import SwiftUI
import SwiftData

@main
struct MainApp: App {
  
  var body: some Scene {
    WindowGroup {
      MainScreen()
        .modelContainer(for: Spell.self)
    }
  }
}
