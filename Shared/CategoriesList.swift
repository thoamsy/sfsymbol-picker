//
//  CategoriesList.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/23.
//

import SwiftUI

struct CategoriesList: View {
  @ObservedObject var sfIcons = SFIconsList()

  var categories: [(String, [String])] {
    let entries = Mirror(reflecting: sfIcons.icons).children.compactMap {
      ($0.label ?? "", $0.value as! [String])
    }

    let allIcons = entries.flatMap { $0.1 }
    return [("All", allIcons)] + entries
  }

  var body: some View {
    return NavigationView {
      if sfIcons.fetching {
        ProgressView()
      } else {
        List(categories, id: \.0) { (category, icons) in
          NavigationLink(
            destination: ContentView(icons: icons)
              .navigationBarTitle(category, displayMode: .inline),
            label: {
            Text(category)
          })
        }.navigationTitle("Symbols")
      }
    }
  }
}

struct CategoriesList_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CategoriesList()
    }
  }
}
