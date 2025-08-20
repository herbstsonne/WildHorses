//
//  GameState.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 17.08.25.
//

import SwiftUI

class GameState: ObservableObject {
  
  @Published var score: Int = 0
  @Published var won: Bool = false
}
