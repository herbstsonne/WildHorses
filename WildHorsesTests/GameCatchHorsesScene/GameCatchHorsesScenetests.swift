//
//  GameCatchHorsesScenetests.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import SpriteKit
import Testing
@testable import WildHorses

@Suite("GameCatchHorsesScene Tests")
struct GameCatchHorsesSceneTests {

  @Test("Touches trigger horse catch")
  func test_touch_callsHorseCaught() throws {
    let scene = GameCatchHorsesScene(gameState: GameState(), settings: Settings())
    let mockHorseAnimation = MockHorseAnimation()

    scene.horseAnimation = mockHorseAnimation

    let location = CGPoint(x: 100, y: 100)
    scene.handleTouch(at: location)

    #expect(mockHorseAnimation.caughtCalled)
    #expect(mockHorseAnimation.caughtLocation == location)
  }
}

extension GameCatchHorsesScene {
  static func testScene(
    gameState: GameState = GameState(),
    settings: Settings = Settings(),
    playerAnimation: PlayerAnimatable? = nil,
    horseAnimation: HorseAnimatable? = nil,
    loopingBackground: LoopingBackground? = nil,
    playerCamera: PlayerCamera? = nil
  ) -> GameCatchHorsesScene {
    let scene = GameCatchHorsesScene(gameState: gameState, settings: settings)
    scene.playerAnimation = MockPlayerAnimation()
    scene.horseAnimation = MockHorseAnimation()
    scene.loopingBackground = MockLoopingBackground()
    scene.playerCamera = MockPlayerCamera()
    return scene
  }
}
