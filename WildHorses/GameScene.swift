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
  
  @Binding var score: Int
  @Binding var showSuccess: Bool

  var background = SKSpriteNode(imageNamed: "horsesrunningbeach_2")
  var pointsLabel = SKLabelNode()
  let box = SKSpriteNode(texture: SKTexture(imageNamed: "nina"), color: .blue, size: CGSize(width: 50, height: 50))
  let hearts = [
    SKSpriteNode(texture: SKTexture(imageNamed: "wild_horse"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "wild_horse"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "wild_horse"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "wild_horse"), color: .blue, size: CGSize(width: 50, height: 50)),
    SKSpriteNode(texture: SKTexture(imageNamed: "wild_horse"), color: .blue, size: CGSize(width: 50, height: 50))
  ]

  init(score: Binding<Int>, showSuccess: Binding<Bool>) {
    _score = score
    _showSuccess = showSuccess
    super.init(size: CGSize(width: 300, height: 400))
    self.scaleMode = .fill
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
    pointsLabel.text = "Points: \(score)"
    addChild(pointsLabel)
    
    box.position = CGPoint(x:self.frame.midX, y:self.frame.minY + 20);
    box.name = "box"
    box.zPosition = 2
    addChild(box)
    
    for heart in hearts {
      createHeart(heart: heart)
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
        if self.children.contains(where: {
          $0 == heart
        })
        {
          print("hit")
          heart.removeFromParent()
          score += 1
          pointsLabel.text = "Points: \(score)"
        }
      }
    }
    
    if !self.children.contains(where: {
      $0.name == "heart"
    }) {
      showSuccess.toggle()
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

  func createHeart(heart: SKSpriteNode) {
   var heartPosition: CGPoint
   heartPosition = CGPoint(x: Double.random(in: self.frame.minX...self.frame.maxX), y: Double.random(in: self.frame.minY...self.frame.maxY))
   heart.position = heartPosition
   heart.name = "heart"
   heart.zRotation = Double.random(in: 0...1)
   heart.zPosition = 1
   addChild(heart)
   
   let actualY = random(min: heart.size.height/2, max: size.height - heart.size.height/2)
   let actualDuration = random(min: CGFloat(10.0), max: CGFloat(20.0))
   let actionMove = SKAction.move(to: CGPoint(x: -heart.size.width/2, y: actualY), duration: TimeInterval(actualDuration))
    let actionMoveDone = SKAction.removeFromParent()
    heart.run(SKAction.sequence([actionMove, actionMoveDone]))
  }
  
  func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }

  func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
  }

}
