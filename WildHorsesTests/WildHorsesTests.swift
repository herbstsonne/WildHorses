//
//  WildHorsesTests.swift
//  WildHorsesTests
//
//  Created by Miriam Pfaffenbach on 09.09.24.
//

@testable import WildHorses
import Testing
import SwiftUI

@Suite("WildHorsesTests")
final class WildHorsesTests {

  @Test("AnimatedHorse")
  func test_animatedHorse_allHorsesAppended() throws {
    
    let scene: SceneNodeProtocol = MockScene()
    let horseNode: SpriteNodeProtocol
    let gameState: GameState = GameState()
    let settings: Settings = Settings()
    var animatedHorse: HorseAnimatable = AnimatedHorse(scene: scene, horseNode: horseNode, gameState: gameState, settings: settings)
    animatedHorse.setup()
    
    #expect(animatedHorse.horses.count == 3)
  }
}
