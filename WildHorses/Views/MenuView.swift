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
  @EnvironmentObject var gameState: GameState
  
  var body: some View {
    NavigationStack {
      HStack {
        VStack(alignment: .leading, spacing: 40) {
          Text("Wildpferde fangen")
            .font(.largeTitle)
            .padding(.top, 24)
          TextField("Spielername:", text: $settings.playerName)
          Stepper("Anzahl Pferde: \(settings.numberOfHorses)", value: $settings.numberOfHorses, in: 1...10)
          HStack {
            Text("Geschwindigkeit: \(UInt(51 - settings.speed))")
            Slider(value: $settings.speed, in: 1...50, step: 1)
          }
          
          NavigationLink("", destination: GameView(), isActive: $startGame)
          
          Button("Play") {
            startGame = true
          }
          .padding()
          .background(Color.green)
          .foregroundColor(.white)
          .cornerRadius(10)
        }
        .onAppear {
          gameState.score = 0
        }
        .frame(width: 400)
        Spacer()
      }
    }
  }
}
