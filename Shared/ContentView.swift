
import SwiftUI
import Combine


struct ContentView: View {
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
                .onTapGesture {
                  selectedIndex = index
                }
                .frame(width: 80, height: 80)
                .border(Color(UIColor.separator))
                .cornerRadius(4)
                .padding([.bottom], 4)
                .contextMenu {
                  Text("Copy Symbol Name")
//                  Button(action: {
//                    UIPasteboard.general.string = name
//                  }, label: {
//                    Text("Copy Symbol Name")
//                  })
                }

              Text(name).foregroundColor(.primary).font(.footnote).lineLimit(2)
            }
            .frame(height: 120)

            //              .background(index == selectedIndex ? Color(UIColor.link) : Color(UIColor.secondarySystemGroupedBackground))
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


