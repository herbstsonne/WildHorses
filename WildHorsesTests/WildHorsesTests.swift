//
//  WildHorsesTests.swift
//  WildHorsesTests
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

@testable import WildHorses
import Testing
import SwiftUI
import SpriteKit

@Suite("WildHorsesTests")
final class WildHorsesTests {

  @Test("AnimatedHorse")
  func test_animatedHorse_allHorsesAppended() {
    
    let scene: SceneNodeProtocol = MockScene()
    let gameState: GameState = GameState()
    let settings: Settings = Settings()
    var animatedHorse: HorseAnimatable = AnimatedHorse(scene: scene, gameState: gameState, settings: settings)
    do {
      try animatedHorse.setup(horseNodes: [SKSpriteNode(), SKSpriteNode(), SKSpriteNode()])
    } catch {
      print(error)
      return
    }

    #expect(animatedHorse.horses.count == 3)
  }
}
