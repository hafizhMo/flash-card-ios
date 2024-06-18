//
//  PlayingView.swift
//  flash-card-ios
//
//  swiping or scrolling page for cards of deck
//
//  Created by Hafizh Mo on 11/06/24.
//

import SwiftUI
import SwiftData

struct PlayingView: View {
  @EnvironmentObject private var router: Router
  @State private var flipped = false
  
  @Query private var spells: [Spell]
  @Query private var decks: [Deck]
  
  var body: some View {
    VStack(alignment: .center) {
      Text("Just swipe left or right, and mark it as reviewed when you already understand the spell")
        .multilineTextAlignment(.center)
        .foregroundStyle(.gray.opacity(0.3))
        .font(.system(size: 24, weight: .heavy))
        .padding(.bottom, 30)
      
      HStack(spacing: 20) {
        ForEach(decks, id:\.self) { deck in
          Button(deck.name) {}
        }
      }
      
      ZStack {
        ForEach(spells, id: \.self) { spell in
          SwipeCard(frontLabel: spell.name, backLabel: spell.detail)
        }
      }
      
      Text("Tap the card to pick the hint")
        .foregroundStyle(.gray.opacity(0.3))
        .font(.system(size: 18, weight: .semibold))
        .padding(.top)
      
      HStack(spacing: 30) {
        Button(action: {
          router.navigate(to: .listDeck)
        }, label: {
          Image(systemName: "numbersign")
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.2), radius: 8, x: 4, y: 4)
        })
        
        Button(action: {
          router.navigate(to: .editDeck)
        }, label: {
          Image(systemName: "text.line.first.and.arrowtriangle.forward")
            .resizable()
            .frame(width: 32, height: 32)
            .padding(20)
            .background(.blue)
            .foregroundStyle(.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.5), radius: 8, x: 4, y: 4)
        })
        
        Button(action: {
          
        }, label: {
          Image(systemName: "shuffle")
            .padding()
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.2), radius: 8, x: 4, y: 4)
        })
      }
      .padding(.top, 30)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.gray.opacity(0.05))
  }
}

//#Preview {
//  PlayingView()
//}
