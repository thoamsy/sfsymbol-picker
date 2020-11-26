//
//  SFSymbolGridItem.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/26.
//

import SwiftUI

struct SFSymbolGridItem: View {
  let symbolName: String
  let tintColor: Color

  var body: some View {
    VStack {
      VStack {
        Image(systemName: symbolName)
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .foregroundColor(tintColor)
          .frame(width: 60, height: 60)
      }.frame(width: 100, height: 80)
      .border(Color(UIColor.separator))
      .cornerRadius(4)
      .padding([.bottom], 4)

      Text(symbolName).foregroundColor(.primary).font(.footnote).lineLimit(2)
    }

  }
}

struct SFSymbolGridItem_Previews: PreviewProvider {
  static var previews: some View {
    SFSymbolGridItem(symbolName: "doc", tintColor: .primary)
      .frame(width: 120, height: 120)
  }
}
