//
//  CardView.swift
//  flash-card-ios
//
//  Created by Hafizh Mo on 14/06/24.
//

import SwiftUI

struct CardView: View {
  var label: String
  var textColor: Color = .black.opacity(0.7)
  var backgroundColor: Color = .white
  
  var body: some View {
    ZStack {
      Rectangle()
        .frame(width: 320, height: 320)
        .cornerRadius(12)
        .foregroundColor(backgroundColor)
        .shadow(color: .gray.opacity(0.3), radius: 20)
      Text(label)
        .font(.system(size: 20, weight: .semibold))
        .foregroundColor(textColor)
        .bold()
        .padding(.horizontal)
        .frame(width: 320)
    }
  }
}

#Preview {
  CardView(label: "Spell something")
}
