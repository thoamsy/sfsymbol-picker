
import SwiftUI
import Combine


struct ContentView: View {
  let icons: [String]
  let title: String
  @State var selectedIndex = -1

  var columns: [GridItem] {
    Array(repeating: .init(.adaptive(minimum: 80)), count: 5)
  }

  var body: some View {
    return NavigationView {
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(Array(icons.enumerated()), id: \.1) { index, name in
            Label(name, systemImage: name)
              .labelStyle(IconOnlyLabelStyle())
              .onTapGesture {
                selectedIndex = index
              }
              .frame(width: 64, height: 64)
              .cornerRadius(4)
              .padding((80 - 64)/2)
              .border(Color(UIColor.separator))
              .background(index == selectedIndex ? Color(UIColor.link) : Color(UIColor.secondarySystemGroupedBackground))
          }
          .font(.title2)
          .padding()
        }
      }
      .navigationTitle(title)
    }
  }
}


