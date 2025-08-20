//
//  Settings.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 12.09.24.
//

import SwiftUI

class Settings: ObservableObject {
    
  @Published var speed: Double = 10
  @Published var numberOfHorses: Int = 3
  @Published var playerName: String = ""
}
