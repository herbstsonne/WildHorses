//
//  PlayerCamera.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import SpriteKit

struct PlayerCamera {
  
  private let scene: SKScene
  private let cameraNode: SKCameraNode

  init(scene: SKScene) {
    self.scene = scene
    self.cameraNode = SKCameraNode()
  }
  
  func setup() {
    cameraNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    scene.camera = cameraNode
    scene.addChild(cameraNode)
  }
  
  func add(scoreLabel: SKLabelNode, gameState: GameState) {
    scoreLabel.color = .gray
    scoreLabel.text = "Points: \(gameState.score)"
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.verticalAlignmentMode = .top
    
    scoreLabel.position = CGPoint(x: scene.size.width/2 - 60, y: scene.size.height/2 - 50);
    
    cameraNode.addChild(scoreLabel)
  }
}
