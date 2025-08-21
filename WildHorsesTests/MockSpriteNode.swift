//
//  MockSpriteNode.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import SpriteKit
import WildHorses

class MockSpriteNode: SpriteNodeProtocol {
  
  var runWasCalled: Bool = false
  var containsWasCalled: Bool = false
  var removeFromParentWasCalled: Bool = false

  var node: SKSpriteNode?
  
  var texture: SKTexture?
  var size: CGSize = .zero
  var position: CGPoint?
  var name: String?
  
  var zPosition: CGFloat
  
  init() {
    zPosition = 0
  }
  
  func run(_ action: SKAction) {
    runWasCalled = true
  }
  
  func contains(_ p: CGPoint) -> Bool {
    // TODO: change maybe
    containsWasCalled = true
    return false
  }
  
  func removeFromParent() {
    // TODO: change maybe
    removeFromParentWasCalled = true
  }
}
