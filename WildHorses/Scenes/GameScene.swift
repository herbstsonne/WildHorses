//
//  GameScene.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene {

  var gameState: GameState
  var settings: Settings

  var background = SKSpriteNode(imageNamed: "horsesrunningbeach_2")
  var pointsLabel = SKLabelNode()
  let player = SKSpriteNode(texture: SKTexture(imageNamed: "nina"), color: .blue, size: CGSize(width: 50, height: 50))
  var horseAnimation: AnimatedHorse

  init(gameState: GameState, settings: Settings) {
    self.gameState = gameState
    self.settings = settings
    horseAnimation = AnimatedHorse(gameState: gameState, settings: settings)
    super.init(size: CGSize(width: 300, height: 400))
    self.scaleMode = .fill
    horseAnimation.parentNode = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func didMove(to view: SKView) {
    //physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

    background.zPosition = 0
    background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    background.size = CGSize(width: self.size.width, height: self.size.height)
    addChild(background)
    
    pointsLabel.position = CGPoint(x:self.frame.maxX - 60, y:self.frame.maxY - 50);
    pointsLabel.color = .gray
    pointsLabel.text = "Points: \(gameState.score)"
    addChild(pointsLabel)
    
    player.position = CGPoint(x:self.frame.midX, y:self.frame.minY + 20);
    player.name = "player"
    player.zPosition = 2
    addChild(player)

    for _ in 0..<settings.numberOfHorses {
      horseAnimation.run(startPosition: CGPoint(x: 700, y: Double.random(in: self.frame.minY + 50...self.frame.maxY - 50)))
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    //let spin = SKAction.rotate(byAngle: CGFloat(Double.pi/4.0), duration: 1)

    let touchLocation = touch.location(in: self)
    let moveAction = SKAction.move(to: touchLocation, duration: 1)
    childNode(withName: "player")?.run(moveAction)
    
    horseAnimation.caught(touchLocation: touchLocation, pointsLabel: pointsLabel)
    
    if !self.children.contains(where: {
      $0.name == "horse"
    }) {
      gameState.won.toggle()
    }
  }
      
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      if let touchLocation = touches.first?.location(in: self), let node = nodes(at: touchLocation).first {
          if node.name != nil {
              if node.name == "background" {
                  background.position = touchLocation
              }
          }
      }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      if let touchLocation = touches.first?.location(in: self), let node = nodes(at: touchLocation).first {
          if node.name != nil {
              if node.name == "background" {
                  background.position = touchLocation
              }
          }
      }
  }
}
