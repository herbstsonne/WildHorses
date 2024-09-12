//
//  FirstView.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import SwiftUI
import SpriteKit

struct FirstView: View {
  
  @State private var youWon = false
  @EnvironmentObject var settings: Settings

  var scene: SKScene {
    let scene = GameScene(score: $settings.score, showSuccess: $youWon)
    scene.size = CGSize(width: 650, height: 300)
    scene.scaleMode = .fill
    return scene
  }
  
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
      .alert("Congratulations", isPresented: $youWon) {
        Text("You got \(settings.score) points :)")
      }
  }
}

#Preview {
    FirstView()
}
