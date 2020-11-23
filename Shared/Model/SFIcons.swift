//
//  SFIcons.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/23.
//

import Foundation
import Combine
import SwiftUI

struct SFIcons: Codable {
//  var version: String = "1.0"
  var Communication: [String] = []
  var Weather: [String] = []
  var ObjectsAndTools: [String] = []
  var Devices: [String] = []
  var Gaming: [String] = []
}

class SFIconsList: ObservableObject {
  let requestURL = URL(string: "https://raw.githubusercontent.com/thoamsy/sf-icon-names/master/sf-name.json")!

  @Published var icons: SFIcons = SFIcons() {
    didSet {
      fetching = false
    }
  }
  @Published var fetching = false

  init() {
    start()
  }

  var publisher: AnyCancellable?

  func start() {
    publisher?.cancel()
    self.fetching = true
    publisher = URLSession.shared
      .dataTaskPublisher(for: requestURL)
      .map(\.data)
      .decode(type: SFIcons.self, decoder: JSONDecoder())
      .retry(2)
      .replaceError(with: SFIcons())
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .assign(to: \.icons, on: self)
  }
}


