//
//  flash_card_iosApp.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 11/06/24.
//

import SwiftUI

@main
struct MainApp: App {
  @ObservedObject var router = Router()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $router.navPath) {
        PlayingView()
          .navigationDestination(for: Router.Destination.self) { destination in
            switch destination {
            case .editCard:
              EditCardView()
            case .editDeck:
              EditDeckView()
            case .home:
              HomeView()
            case .playing:
              PlayingView()
            }
          }
      }
      .environmentObject(router)
    }
  }
}
