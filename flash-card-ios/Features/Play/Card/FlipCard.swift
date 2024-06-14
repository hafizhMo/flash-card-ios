//
//  FlipCardView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 12/06/24.
//

import SwiftUI

struct FlipCard: View {
  
  private let cardSize = UIScreen.screenWidth - 100
  @State private var flipped = false
  var front: String
  var back: String
  
  var body: some View {
    let flipDegrees = flipped ? 180.0 : 0
    
    return VStack {
      ZStack {
        CardView(label: front)
          .flipRotate(flipDegrees).opacity(flipped ? 0.0 : 1.0)
        
        CardView(label: back, textColor: .white, backgroundColor: .gray)
          .flipRotate(-180 + flipDegrees).opacity(flipped ? 1.0 : 0.0)
      }
      .onTapGesture {
        withAnimation {
          self.flipped.toggle()
        }
      }
      
    }
  }
  
}

extension View {
  
  func flipRotate(_ degrees : Double) -> some View {
    return rotation3DEffect(Angle(degrees: degrees), axis: (x: 1.0, y: 0.0, z: 0.0))
  }
}
