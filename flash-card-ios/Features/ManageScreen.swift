//
//  ManageScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 06/07/24.
//

import SwiftUI

struct ManageScreen: View {
  @Binding var toggle: Bool
  @Binding var path: NavigationPath
  
  var body: some View {
    VStack(spacing: 0) {
      VStack {
        ZStack(alignment: .topLeading) {
          HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
              if !toggle {
                Text("..").foregroundColor(.clear)
              }
              
              Button {
                withAnimation(.easeInOut(duration: 0.7)) {
                  toggle.toggle()
                }
              } label: {
                Text("All Spell")
                  .font(!toggle ? .largeTitle : .none)
                  .fontWeight(!toggle ? .bold : .regular)
                  .foregroundColor(!toggle ? .black : .blue)
                  .disabled(!toggle)
              }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
              if toggle {
                Text("..").foregroundColor(.clear)
              }
              
              Button {
                withAnimation(.easeInOut(duration: 0.7)) {
                  toggle.toggle()
                }
              } label: {
                Text("All Deck")
                  .font(toggle ? .largeTitle : .none)
                  .fontWeight(toggle ? .bold : .regular)
                  .foregroundColor(toggle ? .black : .blue)
                  .disabled(toggle)
              }
            }
          }
          .environment(\.layoutDirection, toggle ? .rightToLeft : .leftToRight)
          
          Button {
            path.removeLast()
          } label: {
            Image(systemName: "chevron.left")
            Text("Back")
          }
        }
        .padding([.top, .horizontal])
      }
      .background(Color.manageToolbar)
      
      if toggle {
        AllDeckScreen(path: $path)
      } else {
        AllSpellScreen(path: $path)
      }
    }
    .navigationBarBackButtonHidden()
  }
}
