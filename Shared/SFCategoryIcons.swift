
import SwiftUI
import Combine


struct SFCategoryIcons: View {
  let icons: [String]
  @State private var tintColor: Color = .primary
  @State var selectedIndex = -1

  var columns: [GridItem] {
    Array(repeating: .init(.adaptive(minimum: 100)), count: 4)
  }

  var body: some View {
    return ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(Array(icons.enumerated()), id: \.1) { index, name in
            VStack {
              Image(systemName: name)
                .renderingMode(.template)
                .foregroundColor(tintColor)
//                .onTapGesture {
//                  selectedIndex = index
//                }
                .frame(width: 80, height: 80)
                .border(Color(UIColor.separator))
                .cornerRadius(4)
                .padding([.bottom], 4)
                .contextMenu {
                  Button("YES", action: {})
//                  Button(action: {
//                    UIPasteboard.general.string = name
//                  }, label: {
//                    Label("Copy Symbol Name", systemImage: "doc.on.doc")
//                  })
                }

              Text(name).foregroundColor(.primary).font(.footnote).lineLimit(2)
            }
            .frame(height: 120)
          }
          .font(.title2)
          .padding()
        }
      }
      .navigationBarItems(
        trailing: VStack {
          ColorPicker("", selection: $tintColor, supportsOpacity: false)
        }
      )
//    }
  }
}


