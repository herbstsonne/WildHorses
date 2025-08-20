//
//  AnimatedGirl.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 18.08.25.
//

import SpriteKit

struct AnimatedGirl {
  
  var parentNode: SKNode?
  
  private var gameState: GameState
  private let settings: Settings
  private var girlFrames: [SKTexture] = []
  private let girlAtlas: SKTextureAtlas?
  
  init(scene: SKScene, gameState: GameState, settings: Settings) {
    self.gameState = gameState
    self.settings = settings
    self.parentNode = scene
    girlAtlas = SKTextureAtlas(named: "Girl")
  }
  
  func setup(playerNode: SKSpriteNode) {
    guard let parentNode = parentNode else { return }

    playerNode.position = CGPoint(x: parentNode.frame.midX, y: parentNode.frame.minY + 20);
    playerNode.name = "player"
    playerNode.zPosition = 2
    parentNode.addChild(playerNode)
  }

  mutating func run(startPosition: CGPoint, targetPosition: CGPoint) {
    let girl = parentNode?.childNode(withName: "player")
    let moveAction = SKAction.move(to: targetPosition, duration: settings.speed / 2)
    girl?.run(moveAction)
  }
  
  mutating func calculateAnimation(startPosition: CGPoint, targetPosition: CGPoint) {
    parentNode?.removeAction(forKey: "repeatedAnimation")
    girlFrames.removeAll()

    guard let girlAtlas = girlAtlas else { return }

    let directionX: CGFloat = targetPosition.x > startPosition.x ? 1 : -1
    let directionY: CGFloat = targetPosition.y > startPosition.y ? 1 : -1
    let perspective = directionX == 1 ? "right" : "left"
    let textureNameX = "girl_\(perspective)"
    girlFrames.append(girlAtlas.textureNamed(textureNameX))
    let perspectiveY = directionY == 1 ? "back" : "front"
    let textureNameY = "girl_\(perspectiveY)"
    girlFrames.append(girlAtlas.textureNamed(textureNameY))

    let girl = parentNode?.childNode(withName: "player")
    let repeatingAction = SKAction.repeatForever(SKAction.animate(with: girlFrames, timePerFrame: 0.5))
    girl?.run(repeatingAction, withKey: "repeatedAnimation")
  }
}
