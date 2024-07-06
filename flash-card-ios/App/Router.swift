//
//  Router.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 06/07/24.
//

import SwiftUI

final class Router: ObservableObject {
  
  @Published var navPath = NavigationPath()
  
  func navigate(to destination: Destination) {
    navPath.append(destination)
  }
  
  func navigateBack() {
    navPath.removeLast()
  }
  
  func navigateToRoot() {
    navPath.removeLast(navPath.count)
  }
  
  public enum Destination: Hashable {
    case selectDeck
    case detailDeck(deck: Deck)
    case detailSpell(spell: Spell)
    case manage
  }
}
