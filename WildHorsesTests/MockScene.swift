//
//  MockScene.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import WildHorses
import SpriteKit

class MockScene: SceneNodeProtocol {

  var frame: CGRect

  var size: CGSize
  
  var camera: SKCameraNode?
  
  var children: [SKNode] = []
  
  init() {
    frame = CGRect(x: 1000, y: 500, width: 1000, height: 500)
    size = .zero
  }

  func addChild(_ node: SKNode) {
    children.append(node)
  }
  
  func childNode(withName name: String) -> SKNode? {
    children.first { $0.name == name }
  }
  
  func removeAction(forKey key: String) {
    children.removeAll { $0.action(forKey: key) != nil }
  }
  
  func enumerateChildNodes(withName name: String, using block: @escaping (SKNode, UnsafeMutablePointer<ObjCBool>) -> Void) {
    
  }
}
