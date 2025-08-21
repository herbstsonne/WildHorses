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
  
  var gameScene: SceneNodeProtocol?

  var playerNode: SpriteNodeProtocol
  var scoreNode: SKLabelNode

  var gameState: GameState
  var settings: Settings

  var playerCamera: PlayerCamera?
  var loopingBackground: LoopingBackground?
  var playerAnimation: AnimatedPlayer?
  var horseAnimation: AnimatedHorse?
  
  var horseFrames: [SKTexture] = []

  init(gameState: GameState, settings: Settings) {
    self.gameState = gameState
    self.settings = settings
    self.playerNode = SpriteNode(node: SKSpriteNode(texture: SKTexture(imageNamed: "girl_front"), color: .blue, size: CGSize(width: 50, height: 50)))
    self.scoreNode = SKLabelNode()

    super.init(size: CGSize(width: 300, height: 400))
    
    self.horseFrames = collectHorseFrames()
    self.gameScene = SceneNode(scene: self)
    playerCamera = PlayerCamera(scene: gameScene)
    loopingBackground = LoopingBackground(scene: gameScene)
    horseAnimation = AnimatedHorse(scene: gameScene, gameState: gameState, settings: settings, horseFrames: horseFrames)
    playerAnimation = AnimatedPlayer(scene: gameScene, gameState: gameState, settings: settings)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func update(_ currentTime: TimeInterval) {
    guard let camera = self.camera else { return }

    loopingBackground?.loop(camera: camera)
  }

  override func didMove(to view: SKView) {
    setupInitialGameScene()
    setupAnimations()
  }

  override func didSimulatePhysics() {
    playerCamera?.alignWithPlayer(playerNode: playerNode)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }

    let touchLocation = touch.location(in: self)
    
    playerAnimation?.calculateAnimation(startPosition: CGPoint(x:self.frame.midX, y:self.frame.minY + 20), targetPosition: touchLocation)
    playerAnimation?.run(startPosition: CGPoint(x:self.frame.midX, y:self.frame.minY + 20), targetPosition: touchLocation)
    horseAnimation?.caught(touchLocation: touchLocation, pointsLabel: scoreNode)
    checkForGameWin()
  }
  
  // is called whenever:
  // A finger touches down on the screen (inside your scene),
  // And then that same finger moves while still touching the screen.
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
      let touchLocation = touch.location(in: self)
      playerAnimation?.calculateAnimation(startPosition: CGPoint(x: self.frame.midX, y: self.frame.minY + 20), targetPosition: touchLocation)
    }
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      
  }
  
  private func setupInitialGameScene() {
    guard let view = self.view else { return }

    self.size = view.bounds.size
    
    loopingBackground?.setupBackground()
    playerCamera?.setup()
    playerCamera?.add(scoreLabel: scoreNode, gameState: gameState)
  }
  
  private func setupAnimations() {
    playerAnimation?.setup(playerNode: playerNode)
    horseAnimation?.setup()
  }
  
  private func checkForGameWin() {
    if !self.children.contains(where: {
      $0.name == "horse"
    }) {
      gameState.won.toggle()
    }
  }
  
  private func collectHorseFrames() -> [SKTexture] {
    let horseAtlas = SKTextureAtlas(named: "Horse")
    let numImages = horseAtlas.textureNames.count
    
    for i in 0...numImages - 1 {
      let textureName = "horse_run\(i)"
      horseFrames.append(horseAtlas.textureNamed(textureName))
    }
    return horseFrames
  }
}
