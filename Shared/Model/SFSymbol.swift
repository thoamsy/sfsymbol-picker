//
//  SFIcons.swift
//  SFIconsPicker
//
//  Created by yk on 2020/11/23.
//

import Foundation
import Combine
import SwiftUI


typealias Category = (name: String, categoryIcon: String, icons: [String])


// FIXME: remove the duplicate
struct SFSymbol: Codable {
  //  var version: String = "1.0"
  var Multicolor: [String] = []
  var Communication: [String] = []
  var Weather: [String] = []
  var ObjectsAndTools: [String] = []
  var Devices: [String] = []
  var Gaming: [String] = []
  var Connectivity: [String] = []
  var Transportation: [String] = []
  var Human: [String] = []
  var Nature: [String] = []
  var Editing: [String] = []
  var TextFormatting: [String] = []
  var Media: [String] = []
  var Keyboard: [String] = []
  var Commerce: [String] = []
  var Time: [String] = []
  var Health: [String] = []
  var Shapes: [String] = []
  var Arrows: [String] = []
  var Indices: [String] = []
  var Math: [String] = []

  enum Associate: String {
    case Commuication, Weather, ObjectsAndTools, Devices, Gaming, Connectivity
    case Transportation
    case Human
    case Nature
    case Editing
    case TextFormatting
    case Media
    case Keyboard
    case Commerce
    case Time
    case Health
    case Shapes
    case Arrows
    case Indices
    case Math
    case All
    case Multicolor

    var icon: String {
      switch self {
        case .All:
          return "rectangle.grid.2x2"
        case .Multicolor:
          return "paintpalette"
        case .Commuication:
          return "message"
        case .Weather:
          return "cloud.sun"
        case .ObjectsAndTools:
          return "folder"
        case .Devices:
          return "desktopcomputer"
        case .Gaming:
          return "gamecontroller"
        case .Connectivity:
          return "antenna.radiowaves.left.and.right"
        case .Transportation:
          return "car"
        case .Human:
          return "person"
        case .Nature:
          return "leaf"
        case .Editing:
          return "slider.horizontal.3"
        case .TextFormatting:
          return "textformat"
        case .Media:
          return "playpause"
        case .Keyboard:
          return "command"
        case .Commerce:
          return "cart"
        case .Time:
          return "timer"
        case .Health:
          return "staroflife"
        case .Shapes:
          return "square.on.circle"
        case .Arrows:
          return "arrow.forward"
        case .Indices:
          return "a.circle"
        case .Math:
          return "x.squareroot"
      }
    }
  }

}


class SFIconsModel: ObservableObject {
  let requestURL = URL(string: "https://raw.githubusercontent.com/thoamsy/sf-icon-names/master/sf-name.json")!

  @Published var icons: SFSymbol = SFSymbol() {
    didSet {
      fetching = false
      categories = getAllCategories()
      multicolorSet = Set(icons.Multicolor)
    }
  }

  @Published var fetching = false

  var categories: [Category] = []

  private func getAllCategories() -> [Category] {
    let entries = Mirror(reflecting: icons).children.compactMap { (label, value) -> Category in
      let labelName = label ?? ""
      let icon = SFSymbol.Associate(rawValue: labelName)?.icon ?? SFSymbol.Associate.ObjectsAndTools.icon
      return (labelName, icon, value as! [String])
    }

//    这里的 Set 会导致顺序丢失
    let allIcons = entries.flatMap(\.icons)
    var set: Set<String> = Set()
    let uniqueAllIcons = allIcons.filter {
      if !set.contains($0) {
        set.insert($0)
        return true
      }
      return false
    }
    return [("All",SFSymbol.Associate.All.icon, uniqueAllIcons)] + entries
  }

  private var multicolorSet: Set<String> = Set()

  func canMulticolor(of icon: String) -> Bool {
    multicolorSet.contains(icon)
  }

  init() {
    categories = getAllCategories()
    start()
  }

  var publisher: AnyCancellable?

  func start() {
    publisher?.cancel()
    self.fetching = true
    publisher = URLSession.shared
      .dataTaskPublisher(for: requestURL)
      .map(\.data)
      .decode(type: SFSymbol.self, decoder: JSONDecoder())
      .retry(2)
      .replaceError(with: SFSymbol())
      .eraseToAnyPublisher()
      .receive(on: DispatchQueue.main)
      .assign(to: \.icons, on: self)
  }
}


