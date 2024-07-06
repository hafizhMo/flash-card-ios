//
//  ManageScreen.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 06/07/24.
//

import SwiftUI

struct ManageScreen: View {
  @EnvironmentObject var router: Router
  
  @State private var listState: Bool = true
  
  var body: some View {
    VStack(spacing: 0) {
      VStack {
        ZStack(alignment: .topLeading) {
          HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
              if !listState {
                Text("..").foregroundColor(.clear)
              }
              
              Button {
                withAnimation(.easeInOut(duration: 0.7)) {
                  listState.toggle()
                }
              } label: {
                Text("All Spell")
                  .font(!listState ? .largeTitle : .none)
                  .fontWeight(!listState ? .bold : .regular)
                  .foregroundColor(!listState ? .black : .blue)
                  .disabled(!listState)
              }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
              if listState {
                Text("..").foregroundColor(.clear)
              }
              
              Button {
                withAnimation(.easeInOut(duration: 0.7)) {
                  listState.toggle()
                }
              } label: {
                Text("All Deck")
                  .font(listState ? .largeTitle : .none)
                  .fontWeight(listState ? .bold : .regular)
                  .foregroundColor(listState ? .black : .blue)
                  .disabled(listState)
              }
            }
          }
          .environment(\.layoutDirection, listState ? .rightToLeft : .leftToRight)
          
          Button {
            router.navigateBack()
          } label: {
            Image(systemName: "chevron.left")
            Text("Back")
          }
        }
        .padding([.top, .horizontal])
      }
      .background(Color.manageToolbar)
      
      if listState {
        AllDeckScreen()
      } else {
        AllSpellScreen()
      }
    }
    .navigationBarBackButtonHidden()
  }
}
