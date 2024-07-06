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
  @ObservedObject var router = Router()
  
  var body: some Scene {
    WindowGroup {
      MainScreen()
        .environmentObject(router)
        .modelContainer(for: Deck.self)
    }
  }
}
