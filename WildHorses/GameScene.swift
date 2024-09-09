//
//  GameScene.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
  var background = SKSpriteNode(imageNamed: "horsesrunningbeach_2")
  var settingsButton = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 30))

  override func didMove(to view: SKView) {
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

    background.zPosition = 0
    background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    background.size = CGSize(width: self.size.width, height: self.size.height)
    addChild(background)

    let settingsText = SKLabelNode(text: "Settings")
    settingsText.fontColor = UIColor.white
    settingsText.fontSize = 15
    
    settingsButton.position = CGPoint(x:self.frame.maxX - 40, y:self.frame.maxY - 50);
    settingsButton.color = .gray
    settingsButton.addChild(settingsText)
    addChild(settingsButton)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
    box.position = location
    box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
    background.addChild(box)
    
    if settingsButton.contains(location) {
      background.removeAllChildren()
    }
  }
}
