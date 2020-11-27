//
//  CategoriesList.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/23.
//

import SwiftUI

struct CategoriesList: View {
  @StateObject var sfIcons = SFIconsModel()
  @State private var search = ""
  @State private var searchedIcons: [String] = []
  

  var allIcons: [String] {
    sfIcons.icons.categories[0].icons
  }

  var body: some View {
    return NavigationView {
      VStack {
        Searchbar(text: $search, onCommit: { keyword in
          searchedIcons = allIcons.filter { $0.contains(keyword) }
        }, onCancel: {
          searchedIcons = []
        })
        if !searchedIcons.isEmpty {
          SFCategoryIcons(icons: searchedIcons)
        } else {
          List {
            Section(header: Text("Categories")) {
              ForEach(sfIcons.icons.categories, id: \.0) { (category, categoryIcon, icons) in
                NavigationLink(
                  destination:
                    SFCategoryIcons(
                      icons: icons,
                      shouldRedacted: sfIcons.fetching
                    )
                    .navigationBarTitle(category, displayMode: .inline)

                ) {
                  Label(category, systemImage: categoryIcon)
                }.frame(height: 44)
              }
            }
          }
          .listStyle(InsetGroupedListStyle())
        }
      }
      .navigationTitle("Symbols")
    }
  }
}

struct CategoriesList_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CategoriesList()
      CategoriesList().colorScheme(.dark)
    }
  }
}
