//
//  CardComponent.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 30/06/24.
//

import SwiftUI

struct CardComponent: View {
  @Binding var spells: [Spell]
  @Binding var state: CardState
  
  var body: some View {
    ZStack {
      Button {
        withAnimation {
          state = .reset
        }
      } label: {
        VStack {
          Image(systemName: "arrow.clockwise")
          Text("Reset")
        }
        .foregroundColor(.secondaryButtonLabel)
      }
      
      ForEach(Array(spells.enumerated()), id: \.element) { i, spell in
        SwipeCard(index: i, frontLabel: spell.name, backLabel: spell.detail, state: $state)
      }
      
    }
  }
}


struct SwipeCard: View {
  @State private var offset = CGSize.zero
  var index: Int
  var frontLabel: String
  var backLabel: String
  @Binding var state: CardState
  
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
      .onChange(of: state) { oldValue, newValue in
        switch newValue {
        case .idle:
          return
        case .reset:
          withAnimation(.easeInOut(duration: 0.4)) {
            offset = .zero
          }
        case .shuffle:
          withAnimation(.easeInOut(duration: 0.2)) {
            offset = CGSize(width: (index % 2 == 0) ? 500 : -500, height: 0)
          }
          withAnimation(.easeInOut(duration: 0.8 + Double(index) / 3.5)) {
            offset = .zero
          }
        }
        state = .idle
      }
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
      print("\(frontLabel) reset")
      offset = .zero
    }
  }
}

struct FlipCard: View {
  
  private let cardSize = UIScreen.screenWidth - 100
  @State private var flipped = false
  var front: String
  var back: String
  
  var body: some View {
    let flipDegrees = flipped ? 180.0 : 0
    
    return VStack {
      ZStack {
        CardView(label: front, isWithNote: true, backgroundColor: .primaryCardBackground)
          .flipRotate(flipDegrees).opacity(flipped ? 0.0 : 1.0)
        
        CardView(label: back, textColor: .white, backgroundColor: .secondaryCardBackground)
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

struct CardView: View {
  var label: String
  var isWithNote = false
  var textColor: Color = .black.opacity(0.7)
  var backgroundColor: Color = .white
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20)
        .frame(width: 320, height: 320)
        .cornerRadius(12)
        .foregroundColor(backgroundColor)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.secondaryBackground, lineWidth: 2))
      
      VStack {
        Spacer()
        Text(label)
          .font(.system(size: 20, weight: .semibold))
          .foregroundColor(isWithNote ? .primaryLabel : .tertiaryLabel)
          .bold()
          .padding(12)
        Spacer()
      }
      
      VStack {
        Spacer()
        if isWithNote {
          Text("Tap to see a hint")
            .foregroundColor(.tertiaryLabel)
            .padding(.bottom)
        }
      }
    }
    .frame(width: 320, height: 320)
  }
}


extension View {
  
  func flipRotate(_ degrees : Double) -> some View {
    return rotation3DEffect(Angle(degrees: degrees), axis: (x: 1.0, y: 0.0, z: 0.0))
  }
}

extension UIScreen{
  static let screenWidth = UIScreen.main.bounds.size.width
  static let screenHeight = UIScreen.main.bounds.size.height
  static let screenSize = UIScreen.main.bounds.size
}
