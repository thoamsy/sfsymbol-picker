
import SwiftUI
import Combine


struct SFCategoryIcons: View {
  var icons: [String] = Self.defaultIcons

  @State private var tintColor: Color = .primary
  @State var selectedIndex = -1

  var shouldRedacted = false

  static let defaultIcons = Array(repeating: "photo", count: 20)

  var columns: [GridItem] {
    Array(repeating: .init(.adaptive(minimum: 150)), count: 3)
  }

  var body: some View {
    return ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(Array(icons.enumerated()), id: \.1) { index, name in
            SFSymbolGridItem(
              symbolName: name,
              tintColor: tintColor
            )
          }.frame(height: 120)
          .font(.title2)
          .padding()
        }.redacted(reason: shouldRedacted ? .placeholder : .init())
      }
      .navigationBarItems(
        trailing: VStack {
          ColorPicker("", selection: $tintColor, supportsOpacity: false)
        }
      )
  }
}

//struct RedactingView<Input: View, Output: View>: View {
//  var content: Input
//  var modifier: (Input) -> Output
//
//  @Environment(\.redactionReasons) private var reasons
//
//  var body: some View {
//    if reasons.isEmpty {
//      content
//    } else {
//      modifier(content)
//    }
//  }
//}
//
//extension View {
//  func whenRedacted<T: View>(
//    apply modifier: @escaping (Self) -> T
//  ) -> some View {
//    RedactingView(content: self, modifier: modifier)
//  }
//}
