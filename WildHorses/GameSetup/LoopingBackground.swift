//
//  AnimatedBackground.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import SpriteKit

protocol BackgroundLoopable {
  var scene: SKScene { get }
  
  func setupBackground()
  func loop(camera: SKCameraNode)
}

struct LoopingBackground: BackgroundLoopable {
  
  let scene: SKScene

  init(scene: SKScene) {
    self.scene = scene
  }

  func setupBackground() {
    for i in 0...1 {
      let bg = SKSpriteNode(imageNamed: "prairie")
      bg.anchorPoint = .zero
      bg.position = CGPoint(x: CGFloat(i) * self.scene.size.width, y: 0)
      bg.size = self.scene.size
      bg.zPosition = -1
      bg.name = "background"
      
      bg.texture?.filteringMode = .nearest
      scene.addChild(bg)
    }
  }
  
  func loop(camera: SKCameraNode) {
    self.scene.enumerateChildNodes(withName: "background") { node, _ in
      guard let bg = node as? SKSpriteNode else { return }
      
      self.loopToRight(camera: camera, bg: bg)
      self.loopToLeft(camera: camera, bg: bg)
    }
  }

  private func loopToRight(camera: SKCameraNode, bg: SKSpriteNode) {
    if bg.position.x + bg.size.width < camera.position.x - self.scene.size.width / 2 {
      bg.position.x += bg.size.width * 2 - 1
    }
  }
  
  private func loopToLeft(camera: SKCameraNode, bg: SKSpriteNode) {
    if bg.position.x > camera.position.x + self.scene.size.width / 2 {
      bg.position.x -= bg.size.width * 2 - 1
    }
  }
}
