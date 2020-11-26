//
//  SFSymbolGridItem.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/26.
//

import SwiftUI

struct SFSymbolGridItem: View {
  let symbolName: String
  var tintColor: Color
  var beSelected = false

  var body: some View {
    VStack {
      VStack {
        Image(systemName: symbolName)
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .frame(width: 60, height: 60)
      }.frame(width: 100, height: 80)
      .background(beSelected ? Color.accentColor : Color(UIColor.systemBackground))
      .border(Color(UIColor.separator))
      .cornerRadius(8)
      .padding([.bottom], 4)

      Text(symbolName)
        .font(.callout)
        .lineLimit(2)
    }.foregroundColor(tintColor)
  }
}

struct SFSymbolGridItem_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SFSymbolGridItem(
        symbolName: "doc",
        tintColor: .primary,
        beSelected: true
      )
      .frame(width: 120, height: 120)
      .colorScheme(.dark)
      SFSymbolGridItem(
        symbolName: "doc",
        tintColor: .primary
      )
      .frame(width: 120, height: 120)
      .colorScheme(.dark)
    }
  }
}
