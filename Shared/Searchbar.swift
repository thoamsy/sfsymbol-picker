//
//  Searchbar.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/24.
//

import SwiftUI

struct Searchbar: View {
  @Binding var text: String
  //  @Environment(\.colorScheme) var scheme: ColorScheme

  @State private var isEditing = false

  var body: some View {
    HStack {
      HStack {
        Image(systemName: "magnifyingglass")
        TextField("Search ...", text: $text, onEditingChanged: { _ in
          isEditing = true
        })
        Button(action: {
          text = ""
        }) {
          Image(systemName: "xmark.circle.fill").opacity(isEditing ? 1 : 0)
        }
      }
      .padding(
        EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6)
      )
      .foregroundColor(.secondary)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(10)

      if isEditing {
        Button(action: {
          UIApplication.shared.endEditing(true)
          isEditing = false
          text = ""
        }) {
          Text("Cancel")
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
        .animation(.default)
      }
    }.padding(.horizontal)
  }}

struct Searchbar_Previews: PreviewProvider {
  static var previews: some View {
    Searchbar(text: .constant("foobar"))
  }
}

extension UIApplication {
  func endEditing(_ force: Bool) {
    self.windows
      .filter(\.isKeyWindow)
      .first?
      .endEditing(force)
  }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
  var gesture = DragGesture().onChanged{ _ in
    UIApplication.shared.endEditing(true)
  }
  func body(content: Content) -> some View {
    content.gesture(gesture)
  }
}

extension View {
  func resignKeyboardOnDragGesture() -> some View {
    return modifier(ResignKeyboardOnDragGesture())
  }
}
