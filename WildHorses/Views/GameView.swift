//
//  FirstView.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import SwiftUI
import SpriteKit

struct GameView: View {

  @EnvironmentObject var settings: Settings
  @EnvironmentObject var gameState: GameState
  @Environment(\.dismiss) var dismiss

  var scene: SKScene {
    let scene = GameScene(gameState: gameState, settings: settings)
    scene.size = CGSize(width: 650, height: 300)
    scene.scaleMode = .fill
    return scene
  }
  
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
      .alert("Congratulations", isPresented: $gameState.won) {
        Text("You got \(gameState.score) points :)")
        Button("OK") {
          dismiss()
        }
      }
  }
}

#Preview {
    GameView()
    .environmentObject(Settings())
    .environmentObject(GameState())
}
