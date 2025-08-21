//
//  PlayerCamera.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import SpriteKit

protocol CameraControllable {
  mutating func setup()
  func add(scoreLabel: SKLabelNode, gameState: GameState)
  mutating func alignWithPlayer(playerNode: SpriteNodeProtocol)
}

struct PlayerCamera: CameraControllable {

  private var scene: SceneNodeProtocol?
  private var cameraNode: CameraNodeProtocol

  init(scene: SceneNodeProtocol?) {
    self.scene = scene
    self.cameraNode = CameraNode(node: SKCameraNode())
  }

  mutating func setup() {
    guard var scene = scene else { return }
    cameraNode.position = CGPoint(x: scene.size.width / 2, y: scene.size.height / 2)
    scene.camera = cameraNode.node
    scene.addChild(cameraNode)
  }

  func add(scoreLabel: SKLabelNode, gameState: GameState) {
    guard let scene = scene else { return }

    scoreLabel.color = .gray
    scoreLabel.text = "Points: \(gameState.score)"
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.verticalAlignmentMode = .top
    
    scoreLabel.position = CGPoint(x: scene.size.width/2 - 60, y: scene.size.height/2 - 50);
    
    cameraNode.addChild(scoreLabel)
  }

  mutating func alignWithPlayer(playerNode: SpriteNodeProtocol) {
    guard let scene = scene else { return }

    guard let playerNodePosition = playerNode.position else { return }
    cameraNode.position.x = playerNodePosition.x
    cameraNode.position.y = scene.size.height / 2
  }
}
