//
//  AnimatedHorseTests.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import Testing
import SpriteKit
@testable import WildHorses

final class MockHorseNode: SpriteNodeProtocol {

  var position: CGPoint = .zero
  
  var name: String?
  
  var zPosition: CGFloat = 0.0
  
  var didRunAction = false
  var didRemoveFromParent = false
  
  func run(_ action: SKAction) {
    didRunAction = true
  }
  
  func removeFromParent() {
    didRemoveFromParent = true
  }
  
  var shouldContainPoint = false
  func contains(_ p: CGPoint) -> Bool {
    return shouldContainPoint
  }
}

// MARK: - Tests
@Suite("AnimatedHorse Tests")
struct AnimatedHorseTests {
    
    @Test("setup adds horses to scene and appends to horses array")
    func test_setup_success() throws {
      let scene: SceneNodeProtocol = MockScene(size: CGSize(width: 300, height: 200))
      let gameState = GameState()
      let settings = Settings()
      settings.numberOfHorses = 2
      settings.speed = 1.0
      
      var animatedHorse = AnimatedHorse(scene: scene, gameState: gameState, settings: settings)
      
      let horseNodes = [MockHorseNode(), MockHorseNode()]
      try animatedHorse.setup(horseNodes: horseNodes)
      
      #expect(animatedHorse.horses.count == 2)
      #expect(scene.children.count == 2)
      #expect(animatedHorse.horses.allSatisfy { $0.name == "horse" })
    }
    
    @Test("setup with wrong number of horses triggers fatalError")
    func test_setup_wrongHorseCount() throws {
      let scene = MockScene(size: CGSize(width: 300, height: 200))
      let gameState = GameState()
      let settings = Settings()
      settings.numberOfHorses = 2
      
      var animatedHorse = AnimatedHorse(scene: scene, gameState: gameState, settings: settings)

      #expect(throws: HorseNodeError.wrongNumber("Wrong number of horse nodes")) {
        try animatedHorse.setup(horseNodes: [MockHorseNode()])
      }
    }
    
    @Test("run sets horse properties and runs actions")
    func test_run_setsHorseProperties() throws {
      let scene: SceneNodeProtocol = MockScene(size: CGSize(width: 300, height: 200))
        let gameState = GameState()
        let settings = Settings()
        settings.speed = 1.5
        
        var animatedHorse = AnimatedHorse(scene: scene, gameState: gameState, settings: settings)
        
        let horse = MockHorseNode()
        try animatedHorse.run(startPosition: CGPoint(x: 123, y: 45), horseNode: horse)
        
        #expect(animatedHorse.horses.contains(where: { $0 === horse }))
        #expect(horse.name == "horse")
        #expect(horse.position == CGPoint(x: 123, y: 45))
        #expect(horse.didRunAction == true)
        #expect(scene.children.contains(where: { $0 === horse }))
    }
    
    @Test("caught removes horse if it contains touch location and updates score")
    func test_caught_removesHorseAndUpdatesScore() throws {
      let scene = MockScene(size: CGSize(width: 300, height: 200))
      let gameState = GameState()
      gameState.score = 0
      let settings = Settings()
      
      var animatedHorse = AnimatedHorse(scene: scene, gameState: gameState, settings: settings)
      
      let horse = MockHorseNode()
      scene.addChild(horse)
      animatedHorse.horses.append(horse)
      
      let label = SKLabelNode()
      
      animatedHorse.caught(touchLocation: CGPoint(x: 50, y: 50), pointsLabel: label)
      
      #expect(horse.didRemoveFromParent == true)
      #expect(gameState.score == 1)
      #expect(label.text == "Points: 1")
    }
    
    @Test("caught does nothing if horse does not contain touch location")
    func test_caught_noCatch() throws {
        let scene = MockScene(size: CGSize(width: 300, height: 200))
        let gameState = GameState()
        gameState.score = 0
        let settings = Settings()
        
        var animatedHorse = AnimatedHorse(scene: scene, gameState: gameState, settings: settings)
        
        let horse = MockHorseNode()
        horse.shouldContainPoint = false
        scene.addChild(horse)
        animatedHorse.horses.append(horse)
        
        let label = SKLabelNode()
        
        animatedHorse.caught(touchLocation: CGPoint(x: 50, y: 50), pointsLabel: label)
        
        #expect(horse.didRemoveFromParent == false)
        #expect(gameState.score == 0)
        #expect(label.text == nil)
    }
    
    @Test("caught with no scene does nothing")
    func test_caught_noScene() {
        let gameState = GameState()
        let settings = Settings()
        
        var animatedHorse = AnimatedHorse(scene: nil, gameState: gameState, settings: settings)
        let label = SKLabelNode()
        let horse = MockHorseNode()
        animatedHorse.horses = [horse]
        
        // Should not crash
        animatedHorse.caught(touchLocation: CGPoint(x: 0, y: 0), pointsLabel: label)
        
        #expect(gameState.score == 0)
        #expect(label.text == nil)
    }
}
