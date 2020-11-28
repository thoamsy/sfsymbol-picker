
import SwiftUI
import Combine


struct SFCategoryIcons: View {
  var icons: [String] = Self.defaultIcons
  @SceneStorage("toggleMulticolor") var toggleMultiColor = true
  @AppStorage("selectedSymbolName") var selectedSymbolName = ""
  @EnvironmentObject var sfIcons: SFIconsModel

  var shouldRedacted = false

  static let defaultIcons = Array(repeating: "photo", count: 20)

  var columns: [GridItem] {
    Array(repeating: .init(.adaptive(minimum: 150)), count: 3)
  }

  func isCurrentIconBeSelect(_ name: String) -> Bool {
    return name == selectedSymbolName
  }


  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(Array(icons.enumerated()), id: \.1) { index, name in
          SFSymbolGridItem(
            symbolName: name,
            beSelected: isCurrentIconBeSelect(name),
            isMultiColor: sfIcons.canMulticolor(of: name) ? $toggleMultiColor : .constant(false)
          ).onTapGesture {
            selectedSymbolName = name
          }
        }
        .frame(height: 130)
        .font(.title2)
        .padding()
      }.redacted(reason: shouldRedacted ? .placeholder : .init())
    }.navigationBarItems(
      trailing: NavbarButton(
        highlightColor: Color(UIColor.tertiarySystemFill),
        foregroundColor: .white
      ) {
        toggleMultiColor.toggle()
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
