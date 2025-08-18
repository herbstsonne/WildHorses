//
//  FirstView.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import SwiftUI
import SpriteKit

struct CatchHorsesView: View {

  @EnvironmentObject var settings: Settings
  @EnvironmentObject var gameState: GameState
  @Environment(\.dismiss) var dismiss

  var scene: SKScene {
    let scene = GameCatchHorsesScene(gameState: gameState, settings: settings)
    scene.size = CGSize(width: 650, height: 300)
    scene.scaleMode = .fill
    return scene
  }
  
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
      .alert("Super gemacht!", isPresented: $gameState.won) {
        Text("Du hast \(gameState.score) Punkte gesammelt :)")
        Button("OK") {
          dismiss()
        }
      }
  }
}

#Preview {
    CatchHorsesView()
    .environmentObject(Settings())
    .environmentObject(GameState())
}
