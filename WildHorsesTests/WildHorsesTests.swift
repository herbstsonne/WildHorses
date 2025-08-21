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
  func test_animatedHorse_allHorsesAppended() throws {
    
    let scene: SceneNodeProtocol = MockScene()
    let gameState: GameState = GameState()
    let settings: Settings = Settings()
    var animatedHorse: HorseAnimatable = AnimatedHorse(scene: scene, gameState: gameState, settings: settings)
    try animatedHorse.setup(horseNodes: [SKSpriteNode(), SKSpriteNode(), SKSpriteNode()])

    #expect(animatedHorse.horses.count == 3, "All horses should be appended. Actual count: \(animatedHorse.horses.count)")
  }
}
