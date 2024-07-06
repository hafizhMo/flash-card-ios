//
//  Deck.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 14/06/24.
//

import SwiftData

@Model
class Deck {
  var name: String
  var spells: [Spell] = []
  
  init(name: String = "", spells: [Spell] = []) {
    self.name = name
    self.spells = spells
  }
}
