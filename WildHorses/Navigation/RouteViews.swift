//
//  RouteViews.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

enum RouteViews: String {
  case catchHorses = "catch_horses"
  
  var id : String {
    switch self {
    case .catchHorses:
      return "catch_horses"
    }
  }
}

extension RouteViews: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
