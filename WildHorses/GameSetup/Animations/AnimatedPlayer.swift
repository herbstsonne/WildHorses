//
//  AnimatedGirl.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 18.08.25.
//

import SpriteKit

protocol PlayerAnimatable {
  func setup(playerNode: SpriteNodeProtocol)
  mutating func run(startPosition: CGPoint, targetPosition: CGPoint)
  mutating func calculateAnimation(startPosition: CGPoint, targetPosition: CGPoint)
}

struct AnimatedPlayer: PlayerAnimatable {
  
  private var gameState: GameState
  private let settings: Settings
  private var girlFrames: [SKTexture] = []
  private let girlAtlas: SKTextureAtlas?
  private var scene: SceneNodeProtocol?
  
  init(scene: SceneNodeProtocol?, gameState: GameState, settings: Settings) {
    self.gameState = gameState
    self.settings = settings
    self.scene = scene
    girlAtlas = SKTextureAtlas(named: "Girl")
  }
  
  func setup(playerNode: SpriteNodeProtocol) {
    guard let parentNode = scene else { return }

    playerNode.position = CGPoint(x: parentNode.frame.midX, y: parentNode.frame.minY + 20)
    playerNode.name = "player"
    playerNode.zPosition = 2
    parentNode.addChild(playerNode)
  }

  mutating func run(startPosition: CGPoint, targetPosition: CGPoint) {
    var girl = scene?.childNode(withName: "player")
    let moveAction = SKAction.move(to: targetPosition, duration: settings.speed / 2)
    girl?.run(moveAction)
  }
  
  mutating func calculateAnimation(startPosition: CGPoint, targetPosition: CGPoint) {
    scene?.removeAction(forKey: "repeatedAnimation")
    girlFrames.removeAll()
    
    calculateTextureDependingOnDirection(images: ["right", "left"], startPosition: startPosition.x, targetPosition: targetPosition.x)
    calculateTextureDependingOnDirection(images: ["back", "front"], startPosition: startPosition.y, targetPosition: targetPosition.y)

    let girl = scene?.childNode(withName: "player")
    let repeatingAction = SKAction.repeatForever(SKAction.animate(with: girlFrames, timePerFrame: 0.5))
    girl?.node?.run(repeatingAction, withKey: "repeatedAnimation")
  }
  
  private mutating func calculateTextureDependingOnDirection(
    images: [String],
    startPosition: CGFloat,
    targetPosition: CGFloat
  ) {
    guard let girlAtlas = girlAtlas else { return }

    let direction: CGFloat = targetPosition > startPosition ? 1 : -1
    let perspective = direction == 1 ? images[0] : images[1]
    let textureName = "girl_\(perspective)"
    girlFrames.append(girlAtlas.textureNamed(textureName))
  }
}
