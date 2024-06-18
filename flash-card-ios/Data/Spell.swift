//
//  Card.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 14/06/24.
//

import SwiftData

@Model
class Spell {
  var name: String
  var detail: String
  var notes: String
  @Relationship(inverse: \Deck.spells) var decks: [Deck]
  
  init(name: String, detail: String, notes: String, decks: [Deck] = []) {
    self.name = name
    self.detail = detail
    self.notes = notes
    self.decks = decks
  }
}
