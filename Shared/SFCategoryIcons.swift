
import SwiftUI
import Combine


struct SFCategoryIcons: View {
  var icons: [String] = Self.defaultIcons
  var isMultiColor = false

  @State private var tintColor: Color = .primary
  @AppStorage("selectedSymbolName") var selectedSymbolName = ""

  var shouldRedacted = false

  static let defaultIcons = Array(repeating: "photo", count: 20)

  var columns: [GridItem] {
    Array(repeating: .init(.adaptive(minimum: 150)), count: 3)
  }

  func isCurrentIconBeSelect(_ name: String) -> Bool {
    return name == selectedSymbolName
  }

  var body: some View {
    return ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(Array(icons.enumerated()), id: \.1) { index, name in
          SFSymbolGridItem(
            symbolName: name,
            tintColor: isCurrentIconBeSelect(name) ? .white : tintColor,
            beSelected: isCurrentIconBeSelect(name),
            isMultiColor: isMultiColor
          ).onTapGesture {
            selectedSymbolName = name
          }
        }
        .frame(height: 120)
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
