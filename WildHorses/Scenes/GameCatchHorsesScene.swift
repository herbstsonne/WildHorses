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

  var playerCamera: CameraControllable?
  var loopingBackground: BackgroundLoopable?
  var playerAnimation: PlayerAnimatable?
  var horseAnimation: HorseAnimatable?

  init(
    gameState: GameState,
    settings: Settings,
    playerCamera: CameraControllable? = nil,
    loopingBackground: BackgroundLoopable? = nil,
    playerAnimation: PlayerAnimatable? = nil,
    horseAnimation: HorseAnimatable? = nil
  ) {
    self.gameState = gameState
    self.settings = settings
    self.playerNode = SKSpriteNode(texture: SKTexture(imageNamed: "girl_front"), color: .blue, size: CGSize(width: 50, height: 50))
    self.scoreNode = SKLabelNode()

    super.init(size: CGSize(width: 300, height: 400))
    self.gameScene = self
    self.playerCamera = PlayerCamera(scene: gameScene)
    self.loopingBackground = LoopingBackground(scene: gameScene)
    self.horseAnimation = AnimatedHorse(scene: gameScene, gameState: gameState, settings: settings)
    self.playerAnimation = AnimatedPlayer(scene: gameScene, gameState: gameState, settings: settings)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func update(_ currentTime: TimeInterval) {
    guard let camera = self.camera else { return }

    loopingBackground?.loop(camera: camera)
    if self.children.contains(where: { $0.name == "horse" }) { return }
      do {
        try horseAnimation?.addMoreHorses(camera: camera)
      } catch {
        print(error)
      }
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

    handleTouch(at: touch.location(in: self))
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
  
  func handleTouch(at location: CGPoint) {
    playerAnimation?.calculateAnimation(
        startPosition: CGPoint(x:self.frame.midX, y:self.frame.minY + 20),
        targetPosition: location
    )
    playerAnimation?.run(
        startPosition: CGPoint(x:self.frame.midX, y:self.frame.minY + 20),
        targetPosition: location
    )
    horseAnimation?.caught(touchLocation: location, pointsLabel: scoreNode)
    checkForGameWin()
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

    do {
      try horseAnimation?.setup()
    } catch {
      print(error)
    }
  }

  private func checkForGameWin() {
    if settings.pointsToAchieve <= gameState.score {
      gameState.won.toggle()
    }
  }
}
