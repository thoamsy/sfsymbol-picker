
import SwiftUI
import Combine


struct SFIcons: Codable {
  let version: Float
  let `public`: [String]
}


class SFIconsList: ObservableObject {
  let requestURL = URL(string: "https://raw.githubusercontent.com/thoamsy/sf-icon-names/master/sf-name.json")!

  @Published var icons: [String] = []

  init() {
    start()
  }

  var publisher: AnyCancellable?

  func start() {
    publisher?.cancel()
    publisher = URLSession.shared
      .dataTaskPublisher(for: requestURL)
      .map(\.data)
      .decode(type: SFIcons.self, decoder: JSONDecoder())
      .map(\.public)
      .retry(2)
      .replaceError(with: [])
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .assign(to: \.icons, on: self)
  }
}


struct ContentView: View {
  @ObservedObject var sfIcons = SFIconsList()
  @State var selectedIndex = -1

  var columns: [GridItem] {
    Array(repeating: .init(.adaptive(minimum: 80)), count: 5)
  }

  var body: some View {
    return VStack {
      if sfIcons.icons.isEmpty {
        ProgressView()
      } else {
        ScrollView {
          LazyVGrid(columns: columns) {
            ForEach(Array(sfIcons.icons.enumerated()), id: \.1) { index, name in
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
          }
        }
      }
    }
  }
}


