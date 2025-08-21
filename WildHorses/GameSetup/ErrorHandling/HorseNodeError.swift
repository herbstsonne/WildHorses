//
//  HorseNodeError.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 22.08.25.
//

public enum HorseNodeError: Error {
  case wrongNumber(String)
  
  var id: String {
    switch self {
    case .wrongNumber(let id):
      return id
    }
  }
}

extension HorseNodeError: Equatable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
}
