//
//  HomeScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 30/06/24.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
  @EnvironmentObject var router: Router
  
  @AppStorage("selectedDeck") private var selectedDeck = ""
  
  @Query private var allDeck: [Deck]
  
  @State private var state: CardState = .idle
  @State private var selected = Deck()
  
  var body: some View {
    VStack {
      
      Spacer()
      Text("Just swipe left or right, and mark it as reviewed when you already understand the spell")
        .multilineTextAlignment(.center)
        .foregroundColor(.quaternaryLabel)
        .font(.system(size: 20, weight: .heavy))
      
      Spacer()
      CardComponent(spells: $selected.spells, state: $state)
      Spacer()
      
      HStack(spacing: 32) {
        
        Button {
          state = .shuffle
          withAnimation(.easeInOut(duration: 0.4)){
            selected.spells.shuffle()
          }
        } label: {
          Image(systemName: "shuffle")
            .resizable()
            .frame(width: 20, height: 20, alignment: .center)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.secondaryButtonBackground).shadow(color: .black.opacity(0.1), radius: 4))
            .foregroundColor(.secondaryButtonLabel)
        }
        
        Button {
          router.navigate(to: .selectDeck)
        } label: {
          Image(systemName: "list.bullet.indent")
            .resizable()
            .frame(width: 32, height: 32, alignment: .center)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.primaryButtonBackground).shadow(color: .black.opacity(0.15), radius: 8))
            .foregroundColor(.primaryButtonLabel)
        }
        
        Button {
          router.navigate(to: .manage)
        } label: {
          Image(systemName: "menucard")
            .resizable()
            .frame(width: 20, height: 20, alignment: .center)
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.secondaryButtonBackground).shadow(color: .black.opacity(0.1), radius: 4))
            .foregroundColor(.secondaryButtonLabel)
        }
      }
      Spacer()
    }
    .onAppear {
      if let selectedDeck = allDeck.first(where: { $0.name == selectedDeck }) {
        selected = selectedDeck
      }
      state = .reset
    }
  }
}

