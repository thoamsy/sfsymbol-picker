//
//  SFSymbolGridItem.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/26.
//

import SwiftUI

struct SFSymbolGridItem: View {
  let symbolName: String
  var beSelected = false
  @Binding var isMultiColor: Bool

  var backgroundColor: Color {
    if beSelected {
      return Color.accentColor
    }
    return isMultiColor
      ? Color(UIColor.tertiarySystemGroupedBackground)
      : Color(UIColor.secondarySystemGroupedBackground)
  }

  var body: some View {
    VStack {
      VStack {
        Image(systemName: symbolName)
          .renderingMode(isMultiColor ? .original : .template)
          .font(.system(size: 42))


      }.frame(width: 100, height: 80)
      .padding([.bottom], 4)
      .background(backgroundColor)
      .cornerRadius(4)
      .overlay(
        RoundedRectangle(cornerRadius: 4).stroke(Color(UIColor.systemGray5))
      )
      .foregroundColor(beSelected ? Color(UIColor.systemBackground) : Color.primary)

      Text(symbolName)
        .font(.callout)
        .lineLimit(2)
    }
  }
}

struct SFSymbolGridItem_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SFSymbolGridItem(
        symbolName: "mic",
        beSelected: true,
        isMultiColor: .constant(true)
      )
      .frame(width: 120, height: 120)
      .colorScheme(.dark)

      SFSymbolGridItem(
        symbolName: "mic",
        beSelected: false,
        isMultiColor: .constant(true)
      )
      .frame(width: 120, height: 120)
      .colorScheme(.dark)

      SFSymbolGridItem(
        symbolName: "wifi",
        isMultiColor: .constant(false)
      )
      .frame(width: 120, height: 120)
      .colorScheme(.dark)
    }
  }
}
