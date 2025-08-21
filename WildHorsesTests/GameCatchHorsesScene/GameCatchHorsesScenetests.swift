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

    @Test("didMove sets up scene and animations")
    func test_didMove() {
        let scene = GameCatchHorsesScene.testScene()
        let view = SKView()
        scene.didMove(to: view)

        let camera = scene.playerCamera as! MockPlayerCamera
        let background = scene.loopingBackground as! MockLoopingBackground
        let playerAnim = scene.playerAnimation as! MockPlayerAnimation
        let horseAnim = scene.horseAnimation as! MockHorseAnimation

        #expect(camera.setupCalled)
        #expect(camera.addCalled)
        #expect(background.setupCalled)
        #expect(playerAnim.setupCalled)
        #expect(horseAnim.setupCalled)
        #expect(horseAnim.setupCount == scene.settings.numberOfHorses)
    }

    @Test("update loops background when camera is present")
    func test_update_callsLoop() {
        let scene = GameCatchHorsesScene.testScene()
        scene.camera = SKCameraNode()
        scene.update(0)
        let background = scene.loopingBackground as! MockLoopingBackground
        #expect(background.loopCalled)
    }

    @Test("didSimulatePhysics aligns camera with player")
    func test_didSimulatePhysics() {
        let scene = GameCatchHorsesScene.testScene()
        scene.didSimulatePhysics()
        let camera = scene.playerCamera as! MockPlayerCamera
        #expect(camera.alignCalled)
    }

    @Test("handleTouch triggers player and horse animations")
    func test_handleTouch() {
        let scene = GameCatchHorsesScene.testScene()
        let location = CGPoint(x: 50, y: 50)
        scene.handleTouch(at: location)

        let playerAnim = scene.playerAnimation as! MockPlayerAnimation
        let horseAnim = scene.horseAnimation as! MockHorseAnimation

        #expect(playerAnim.calculated)
        #expect(playerAnim.ran)
        #expect(horseAnim.caughtCalled)
        #expect(horseAnim.caughtLocation == location)
    }

    @Test("touchesBegan calls handleTouch")
    func test_touchesBegan() {
        let scene = GameCatchHorsesScene.testScene()
        let touch = MockTouch(location: CGPoint(x: 10, y: 10))
        scene.touchesBegan([touch], with: nil)
        let horseAnim = scene.horseAnimation as! MockHorseAnimation
        #expect(horseAnim.caughtCalled)
    }

    @Test("touchesMoved calculates animation")
    func test_touchesMoved() {
        let scene = GameCatchHorsesScene.testScene()
        let touch = MockTouch(location: CGPoint(x: 20, y: 20))
        scene.touchesMoved([touch], with: nil)
        let playerAnim = scene.playerAnimation as! MockPlayerAnimation
        #expect(playerAnim.calculated)
    }

    @Test("checkForGameWin toggles won when no horses")
    func test_checkForGameWin() {
        let state = GameState()
        let scene = GameCatchHorsesScene.testScene(gameState: state)
        #expect(state.won == false)
        scene.handleTouch(at: CGPoint(x: 0, y: 0)) // will call checkForGameWin
        #expect(state.won == true)
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
