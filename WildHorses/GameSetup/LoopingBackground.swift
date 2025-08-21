//
//  AnimatedBackground.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import SpriteKit

public protocol BackgroundLoopable {
  var scene: SceneNodeProtocol? { get }
  
  func setupBackground()
  func loop(camera: SKCameraNode)
}

struct LoopingBackground: BackgroundLoopable {
  
  var scene: SceneNodeProtocol?

  init(scene: SceneNodeProtocol?) {
    self.scene = scene
  }

  func setupBackground() {
    guard let scene = scene else { return }
    for i in 0...1 {
      let bg = SKSpriteNode(imageNamed: "prairie")
      bg.anchorPoint = .zero
      bg.position = CGPoint(x: CGFloat(i) * scene.size.width, y: 0)
      bg.size = scene.size
      bg.zPosition = -1
      bg.name = "background"
      
      bg.texture?.filteringMode = .nearest
      scene.addChild(bg)
    }
  }
  
  func loop(camera: SKCameraNode) {
    guard let scene = scene else { return }

    scene.enumerateChildNodes(withName: "background") { node, _ in
      guard let bg = node as? SKSpriteNode else { return }
      
      self.loopToRight(camera: camera, bg: bg)
      self.loopToLeft(camera: camera, bg: bg)
    }
  }

  private func loopToRight(camera: SKCameraNode, bg: SKSpriteNode) {
    guard let scene = scene else { return }
    if bg.position.x + bg.size.width < camera.position.x - scene.size.width / 2 {
      bg.position.x += bg.size.width * 2 - 1
    }
  }
  
  private func loopToLeft(camera: SKCameraNode, bg: SKSpriteNode) {
    guard let scene = scene else { return }
    if bg.position.x > camera.position.x + scene.size.width / 2 {
      bg.position.x -= bg.size.width * 2 - 1
    }
  }
}
