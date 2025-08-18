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
  
  init(gameState: GameState, settings: Settings) {
    self.gameState = gameState
    self.settings = settings
    girlAtlas = SKTextureAtlas(named: "Girl")
  }
  
  mutating func run(startPosition: CGPoint, targetPosition: CGPoint) {
    let girl = parentNode?.childNode(withName: "player")
    let moveAction = SKAction.move(to: targetPosition, duration: settings.speed)
    girl?.run(moveAction)
  }
  
  mutating func calculateAnimation(startPosition: CGPoint, targetPosition: CGPoint) {
    parentNode?.removeAction(forKey: "repeatedAnimation")
    girlFrames.removeAll()

    guard let girlAtlas = girlAtlas else { return }

    let directionX: CGFloat = targetPosition.x > startPosition.x ? 1 : -1
    let directionY: CGFloat = targetPosition.y > startPosition.y ? 1 : -1
    let perspective = directionX == 1 ? "front" : "back"
    let textureNameX = "girl_\(perspective)"
    girlFrames.append(girlAtlas.textureNamed(textureNameX))
    let perspectiveY = directionY == 1 ? "right" : "left"
    let textureNameY = "girl_\(perspectiveY)"
    girlFrames.append(girlAtlas.textureNamed(textureNameY))

    let girl = parentNode?.childNode(withName: "player")
    let repeatingAction = SKAction.repeatForever(SKAction.animate(with: girlFrames, timePerFrame: 0.5))
    girl?.run(repeatingAction, withKey: "repeatedAnimation")
  }
}
