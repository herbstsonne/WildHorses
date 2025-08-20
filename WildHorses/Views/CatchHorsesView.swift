//
//  FirstView.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import SwiftUI
import SpriteKit

struct CatchHorsesView: View {

  @EnvironmentObject private var settings: Settings
  @EnvironmentObject private var gameState: GameState
  @Environment(\.dismiss) private var dismiss
  @Environment(\.verticalSizeClass) private var verticalSizeClass

  var scene: SKScene {
    let scene = GameCatchHorsesScene(gameState: gameState, settings: settings)
    scene.size = CGSize(width: 650, height: 300)
    scene.scaleMode = .fill
    return scene
  }
  
  var body: some View {
    if verticalSizeClass == .compact {
      SpriteView(scene: scene)
        .ignoresSafeArea()
        .alert("Super gemacht, \(settings.playerName)!", isPresented: $gameState.won) {
          Text("Du hast \(gameState.score) Punkte gesammelt :)")
          Button("OK") {
            dismiss()
          }
        }
    }
    else {
      Text("Halte die App quer, um das Game zu spielen.")
    }
  }
}

#Preview {
    CatchHorsesView()
    .environmentObject(Settings())
    .environmentObject(GameState())
}
