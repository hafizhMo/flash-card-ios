//
//  Router.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 11/06/24.
//

import SwiftUI

extension UIScreen{
  static let screenWidth = UIScreen.main.bounds.size.width
  static let screenHeight = UIScreen.main.bounds.size.height
  static let screenSize = UIScreen.main.bounds.size
}

final class Router: ObservableObject {
  
  public enum Destination: Hashable {
    case editDeck
    case editCard
    case home
    case playing
  }
  
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
}
