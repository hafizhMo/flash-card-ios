//
//  ContentView.swift
//  SwapStackOrder
//
//  Created by Hafizh Mo on 06/07/24.
//

import SwiftUI

struct ContentView: View {
  @State var toggle = false
  var body: some View {
    VStack {
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
                Text("Large title")
                  .font(!toggle ? .largeTitle : .none)
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
                Text("Toolbar")
                  .font(toggle ? .largeTitle : .none)
                  .foregroundColor(toggle ? .black : .blue)
                  .disabled(toggle)
              }
            }
          }
          .environment(\.layoutDirection, toggle ? .rightToLeft : .leftToRight)
          
          Button {
            
          } label: {
            Image(systemName: "chevron.left")
            Text("Back")
          }
        }
        .padding()
      }
      
      Spacer()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
