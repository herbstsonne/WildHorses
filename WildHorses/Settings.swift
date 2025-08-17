//
//  Settings.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 12.09.24.
//

import SwiftUI

class Settings: ObservableObject {
    
  @Published var numberOfHorses: Int = 3
  @Published var playerName: String = "Nina"
}
