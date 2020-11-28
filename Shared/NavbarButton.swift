//
//  NavbarButton.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/28.
//

import SwiftUI

struct NavbarButton: View {
  @State var pressed = false
  let highlightColor: Color
  var foregroundColor: Color
  let action: () -> Void

  var body: some View {
    Button(action: {
      pressed.toggle()
      action()
    }, label: {
      Label("Toggle Multicolor", systemImage: "sparkles")
        .font(.title2)
        .labelStyle(IconOnlyLabelStyle())
    }).frame(width: 32, height: 32)
    .background(pressed ? highlightColor : Color(UIColor.systemGroupedBackground))
    .foregroundColor(pressed ? foregroundColor : Color.accentColor)
    .cornerRadius(6)
  }
}

struct NavbarButton_Previews: PreviewProvider {
  static var previews: some View {
    NavbarButton(highlightColor: Color(UIColor.secondarySystemBackground), foregroundColor: .white) {
    }.colorScheme(.dark)
  }
}
