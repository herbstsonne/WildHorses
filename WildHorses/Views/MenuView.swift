//
//  MenuView.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 17.08.25.
//

import SwiftUI
import SpriteKit

struct MenuView: View {

  @State private var startGame = false
  @EnvironmentObject var settings: Settings
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 40) {
        Text("Wildpferde")
                  .font(.largeTitle)
                  .bold()
            
        TextField("Spielername:", text: $settings.playerName)
        Stepper("Anzahl Pferde: \(settings.numberOfHorses)", value: $settings.numberOfHorses, in: 1...10)
          
        NavigationLink("", destination: GameView(), isActive: $startGame)
        
        Button("Play") {
            startGame = true
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
      }
    }
  }
}
