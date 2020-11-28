//
//  SFIconsPickerApp.swift
//  Shared
//
//  Created by yk on 2020/11/21.
//

import SwiftUI

@main
struct SFIconsPickerApp: App {
    var body: some Scene {
        WindowGroup {
          CategoriesList().environmentObject(SFIconsModel())
        }
    }
}
