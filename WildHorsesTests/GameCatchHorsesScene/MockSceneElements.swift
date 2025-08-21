//
//  MockAnimatedHorse.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import WildHorses
import SpriteKit

class MockHorseAnimation: HorseAnimatable {
  
  private(set) var caughtCalled = false
  private(set) var caughtLocation: CGPoint?
  private(set) var setupCalled = false
  private(set) var setupCount = 0
  private(set) var runCalled = false

  var horses: [any SpriteNodeProtocol] = []
  
  func setup(horseNodes: [any SpriteNodeProtocol]) throws {
    setupCalled = true
    setupCount = horses.count
  }
  
  func run(startPosition: CGPoint, horseNode: any SpriteNodeProtocol) throws {
    runCalled = true
  }

  func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode) {
    caughtCalled = true
    caughtLocation = touchLocation
  }
}

final class MockPlayerAnimation: PlayerAnimatable {
  var setupCalled = false
  var calculated = false
  var ran = false
  var startPosition: CGPoint?
  var targetPosition: CGPoint?

  func setup(playerNode: SpriteNodeProtocol) { setupCalled = true }
  func calculateAnimation(startPosition: CGPoint, targetPosition: CGPoint) {
      calculated = true
      self.startPosition = startPosition
      self.targetPosition = targetPosition
  }
  func run(startPosition: CGPoint, targetPosition: CGPoint) {
      ran = true
      self.startPosition = startPosition
      self.targetPosition = targetPosition
  }
}

final class MockLoopingBackground: BackgroundLoopable {
  
  var setupCalled = false
  var loopCalled = false
  var scene: (any WildHorses.SceneNodeProtocol)?

  func setupBackground() { setupCalled = true }
  func loop(camera: SKCameraNode) { loopCalled = true }
}

final class MockPlayerCamera: CameraControllable {
  var setupCalled = false
  var alignCalled = false
  var addCalled = false

  func setup() { setupCalled = true }
  func alignWithPlayer(playerNode: SpriteNodeProtocol) { alignCalled = true }
  func add(scoreLabel: SKLabelNode, gameState: GameState) { addCalled = true }
}

