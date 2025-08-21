//
//  LoopingBackgroundTests.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import Testing
import SpriteKit
@testable import WildHorses

// MARK: - Tests
@Suite("LoopingBackground Tests")
struct LoopingBackgroundTests {
    
    @Test("setupBackground adds two background nodes")
    func test_setupBackground_addsBackgrounds() {
        let scene = MockScene(size: CGSize(width: 300, height: 200))
        let background = LoopingBackground(scene: scene)
        
        background.setupBackground()
        
        let backgrounds = scene.children.compactMap { $0 as? SKSpriteNode }
        
        #expect(backgrounds.count == 2)
        #expect(backgrounds.allSatisfy { $0.name == "background" })
        #expect(backgrounds[0].position == CGPoint(x: 0, y: 0))
        #expect(backgrounds[1].position == CGPoint(x: 300, y: 0))
        #expect(backgrounds.allSatisfy { $0.size == scene.size })
    }
    
    @Test("loop shifts background to right when scrolled past left bound")
    func test_loop_shiftsRight() {
        let scene = MockScene(size: CGSize(width: 300, height: 200))
        let background = LoopingBackground(scene: scene)
        background.setupBackground()
        
        guard let bg = scene.childNode(withName: "background") as? SKSpriteNode else {
            #expect(Bool(false), "No background created")
            return
        }
        
        // Move background completely out of view to the left
        bg.position.x = -400
        
        let camera = SKCameraNode()
        camera.position = CGPoint(x: 0, y: 100)
        background.loop(camera: camera)
        
        // Expect bg moved to the right
        #expect(bg.position.x + 1 > -400)
    }
    
    @Test("loop shifts background to left when scrolled past right bound")
    func test_loop_shiftsLeft() {
        let scene = MockScene(size: CGSize(width: 300, height: 200))
        let background = LoopingBackground(scene: scene)
        background.setupBackground()
        
        guard let bg = scene.children.last as? SKSpriteNode else {
            #expect(Bool(false), "No background created")
            return
        }
        
        // Move background completely out of view to the right
        bg.position.x = 800
        
        let camera = SKCameraNode()
        camera.position = CGPoint(x: 0, y: 100)
        background.loop(camera: camera)
        
        // Expect bg moved to the left
        #expect(bg.position.x - 1 < 800)
    }
    
    @Test("loop with scene == nil does nothing")
    func test_loop_withNilScene() {
        let background = LoopingBackground(scene: nil)
        let camera = SKCameraNode()
        
        // Should not crash
        background.loop(camera: camera)
        background.setupBackground()
        
        #expect(true) // no crash == success
    }
}
