//
//  FirstView.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import SwiftUI
import SpriteKit

struct FirstView: View {
  
  var scene: SKScene {
    let scene = GameScene()
    scene.size = CGSize(width: 650, height: 300)
    scene.scaleMode = .fill
    return scene
  }
  
  var body: some View {
    SpriteView(scene: scene)
      .ignoresSafeArea()
  }
}

#Preview {
    FirstView()
}
