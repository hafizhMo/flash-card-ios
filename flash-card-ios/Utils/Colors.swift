//
//  Colors.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 06/07/24.
//

import SwiftUI

extension Color {
  
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }
    
    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue:  Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
  
  static let primaryLabel = neutral_900
  static let secondaryLabel = neutral_700
  static let tertiaryLabel = neutral_500
  static let quaternaryLabel = neutral_300
  
  static let primaryBackground = neutral_0
  static let secondaryBackground = neutral_100
  
  static let primaryCardBackground = neutral_0
  static let secondaryCardBackground = neutral_50
  
  static let primaryButtonLabel = accent_50
  static let secondaryButtonLabel = accent_400
  static let primaryButtonBackground = accent_400
  static let secondaryButtonBackground = accent_100
  
  private static let neutral_0 = Color(hex: "ffffff")
  private static let neutral_50 = Color(hex: "fafafa")
  private static let neutral_100 = Color(hex: "f5f5f5")
  private static let neutral_200 = Color(hex: "eeeeee")
  private static let neutral_300 = Color(hex: "e0e0e0")
  private static let neutral_400 = Color(hex: "bdbdbd")
  private static let neutral_500 = Color(hex: "9e9e9e")
  private static let neutral_600 = Color(hex: "757575")
  private static let neutral_700 = Color(hex: "616161")
  private static let neutral_800 = Color(hex: "424242")
  private static let neutral_900 = Color(hex: "212121")
  
  private static let accent_50 = Color(hex: "f8e7ee")
  private static let accent_100 = Color(hex: "f2d0de")
  private static let accent_200 = Color(hex: "ecb9cd")
  private static let accent_300 = Color(hex: "e6a2bd")
  private static let accent_400 = Color(hex: "e08bac")
  private static let accent_500 = Color(hex: "da749c")
  private static let accent_600 = Color(hex: "d45d8b")
  private static let accent_700 = Color(hex: "ce467a")
  private static let accent_800 = Color(hex: "c82f6a")
  private static let accent_900 = Color(hex: "c2185a")
}
