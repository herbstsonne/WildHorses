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
  var pointsLabel = SKLabelNode()
  let box = SKSpriteNode(texture: SKTexture(imageNamed: "painted_horse"), color: .blue, size: CGSize(width: 50, height: 50))
  let hearts = [
    SKSpriteNode(texture: SKTexture(imageNamed: "heart"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "heart"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "heart"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "heart"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "heart"), color: .blue, size: CGSize(width: 50, height: 50))
  ]
  
  var boxPosition = CGPoint()
  var points = 0

  func update(_ currentTime: TimeInterval, for scene: SKScene) {
    boxPosition = box.position
  }

  override func didMove(to view: SKView) {
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)

    background.zPosition = 0
    background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    background.size = CGSize(width: self.size.width, height: self.size.height)
    addChild(background)
    
    pointsLabel.position = CGPoint(x:self.frame.maxX - 60, y:self.frame.maxY - 50);
    pointsLabel.color = .gray
    pointsLabel.text = "Points: \(points)"
    addChild(pointsLabel)
    
    box.position = CGPoint(x:self.frame.midX, y:self.frame.minY + 20);
    box.name = "box"
    box.zPosition = 2
    addChild(box)
    
    var heartPosition: CGPoint
    for heart in hearts {
      heartPosition = CGPoint(x: Double.random(in: self.frame.minX...self.frame.maxX), y: Double.random(in: self.frame.minY...self.frame.maxY))
      heart.position = heartPosition
      heart.name = "heart"
      heart.zRotation = Double.random(in: 0...1)
      heart.zPosition = 1
      addChild(heart)
    }
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    //let spin = SKAction.rotate(byAngle: CGFloat(Double.pi/4.0), duration: 1)

    let touchLocation = touch.location(in: self)
    let moveAction = SKAction.move(to: touchLocation, duration: 1)
    childNode(withName: "box")?.run(moveAction)
    
    for heart in hearts {
      if heart.contains(touchLocation) {
        print("hit")
        heart.removeFromParent()
        points += 1
        pointsLabel.text = "Points: \(points)"
      }
    }
    
    if !self.children.contains(where: {
      $0.name == "heart"
    }) {
      
    }
  }
}
