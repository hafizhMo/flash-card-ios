//
//  SwipeCard.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 14/06/24.
//

import SwiftUI

struct SwipeCard: View {
  @State private var offset = CGSize.zero
  var frontLabel: String
  var backLabel: String
  
  var body: some View {
    FlipCard(front: frontLabel, back: backLabel)
      .offset(x: offset.width * 1, y: offset.height * 0.4)
      .rotationEffect(.degrees(Double(offset.width / 40)))
      .gesture(
        DragGesture()
          .onChanged { gesture in
            offset = gesture.translation
            withAnimation {
//              changeColor(width: offset.width)
            }
          }
          .onEnded { _ in
            withAnimation {
              swipeCard(width: offset.width)
//              changeColor(width: offset.width)
            }
          }
      )
  }
  
  func swipeCard(width: CGFloat) {
    switch width {
    case -500...(-150):
      print("\(frontLabel) removed")
      offset = CGSize(width: -500, height: 0)
    case 150...500:
      print("\(frontLabel) added")
      offset = CGSize(width: 500, height: 0)
    default:
      offset = .zero
    }
  }
  
//  func changeColor(width: CGFloat) {
//    switch width {
//    case -500...(-130):
//      color = .red
//    case 130...500:
//      color = .green
//    default:
//      color = .black
//    }
//  }

}
