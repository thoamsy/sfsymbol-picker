//
//  CategoriesList.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/23.
//

import SwiftUI

struct CategoriesList: View {
  @ObservedObject var sfIcons = SFIconsList()

  var body: some View {
    return NavigationView {
      if sfIcons.fetching {
        ProgressView()
      } else {
        List {
          Section(header: Text("Categories")) {
            ForEach(sfIcons.icons.categories, id: \.0) { (category, categoryIcon, icons) in
              NavigationLink(
                destination: ContentView(icons: icons)
                  .navigationBarTitle(category, displayMode: .inline)
              ) {
                Label(category, systemImage: categoryIcon)
              }.frame(height: 44)
            }
          }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Symbols")
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
