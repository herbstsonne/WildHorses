//
//  GameScene.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import Foundation
import SpriteKit
import SwiftUI

class GameCatchHorsesScene: SKScene {

  var gameState: GameState
  var settings: Settings
  var pointsLabel = SKLabelNode()
  let player = SKSpriteNode(texture: SKTexture(imageNamed: "girl_front"), color: .blue, size: CGSize(width: 50, height: 50))
  var playerAnimation: AnimatedGirl
  var horseAnimation: AnimatedHorse

  init(gameState: GameState, settings: Settings) {
    self.gameState = gameState
    self.settings = settings
    horseAnimation = AnimatedHorse(gameState: gameState, settings: settings)
    playerAnimation = AnimatedGirl(gameState: gameState, settings: settings)
    super.init(size: CGSize(width: 300, height: 400))
    //self.scaleMode = .fill
    horseAnimation.parentNode = self
    playerAnimation.parentNode = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupBackground() {
    for i in 0...1 {
      let bg = SKSpriteNode(imageNamed: "prairie")
      bg.anchorPoint = .zero
      bg.position = CGPoint(x: CGFloat(i) * self.size.width, y: 0)
      bg.size = self.size
      bg.zPosition = -1
      bg.name = "background"
      
      bg.texture?.filteringMode = .nearest
      addChild(bg)
    }
  }

  override func update(_ currentTime: TimeInterval) {
      guard let camera = self.camera else { return }
      
      enumerateChildNodes(withName: "background") { node, _ in
        if let bg = node as? SKSpriteNode {
              
        // Loop to the right
        if bg.position.x + bg.size.width < camera.position.x - self.size.width / 2 {
          bg.position.x += bg.size.width * 2 - 1
        }
          
        // Loop to the left
        if bg.position.x > camera.position.x + self.size.width / 2 {
            bg.position.x -= bg.size.width * 2 - 1
        }
      }
    }
  }

  override func didMove(to view: SKView) {

    self.size = view.bounds.size
    
    setupBackground()
    
    let cameraNode = SKCameraNode()
    cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
    self.camera = cameraNode
    addChild(cameraNode)

    pointsLabel.color = .gray
    pointsLabel.text = "Points: \(gameState.score)"
    pointsLabel.horizontalAlignmentMode = .right
    pointsLabel.verticalAlignmentMode = .top
    
    if let scene = self.scene {
      pointsLabel.position = CGPoint(x: scene.size.width/2 - 60, y: scene.size.height/2 - 50);
    }
    cameraNode.addChild(pointsLabel)

    player.position = CGPoint(x:self.frame.midX, y:self.frame.minY + 20);
    player.name = "player"
    player.zPosition = 2
    addChild(player)

    for _ in 0..<settings.numberOfHorses {
      horseAnimation.run(startPosition: CGPoint(x: 700, y: Double.random(in: self.frame.minY + 50...self.frame.maxY - 170)))
    }
  }

  override func didSimulatePhysics() {
    camera?.position.x = player.position.x
    camera?.position.y = size.height / 2 // keep vertical center fixed
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }

    let touchLocation = touch.location(in: self)
    
    playerAnimation.calculateAnimation(startPosition: CGPoint(x:self.frame.midX, y:self.frame.minY + 20), targetPosition: touchLocation)
    playerAnimation.run(startPosition: CGPoint(x:self.frame.midX, y:self.frame.minY + 20), targetPosition: touchLocation)
    
    horseAnimation.caught(touchLocation: touchLocation, pointsLabel: pointsLabel)
    
    if !self.children.contains(where: {
      $0.name == "horse"
    }) {
      gameState.won.toggle()
    }
  }
  
  // is called whenever:
  // A finger touches down on the screen (inside your scene),
  // And then that same finger moves while still touching the screen.
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let touchLocation = touch.location(in: self)
      playerAnimation.calculateAnimation(startPosition: CGPoint(x:self.frame.midX, y:self.frame.minY + 20), targetPosition: touchLocation)
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
  }
}
