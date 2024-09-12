//
//  WildHorsesApp.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import SwiftUI

@main
struct WildHorsesApp: App {
  
  @StateObject private var settings = Settings()

  var body: some Scene {
    WindowGroup {
      FirstView()
        .environmentObject(settings)
    }
  }
}
