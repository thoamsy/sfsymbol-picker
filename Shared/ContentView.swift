
import SwiftUI
import Combine


struct ContentView: View {
  let icons: [String]
  let title: String
  @State private var tintColor: Color = .primary
  @State var selectedIndex = -1

  var columns: [GridItem] {
    Array(repeating: .init(.adaptive(minimum: 100)), count: 4)
  }

  var body: some View {
    print(tintColor)
    return NavigationView {
      ScrollView {
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
                .cornerRadius(4)
                .border(Color(UIColor.separator))
                .padding([.bottom], 4)

              Text(name).foregroundColor(.primary).font(.footnote)
            }
            .frame(height: 120)
            //              .background(index == selectedIndex ? Color(UIColor.link) : Color(UIColor.secondarySystemGroupedBackground))
          }
          .font(.title2)
          .padding()
        }
      }
      .navigationTitle(title)
      .navigationBarItems(trailing: ColorPicker("", selection: $tintColor, supportsOpacity: false))
    }
  }
}


