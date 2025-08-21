//
//  MockScene.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import WildHorses
import SpriteKit

class MockScene: SceneNodeProtocol {

  var removeActionWasCalled: Bool = false
  var enumerateChildNodesWasCalled: Bool = false

  var frame: CGRect

  var size: CGSize
  
  var camera: SKCameraNode?
  
  var children: [SKNode] = []
  var mockChildren: [SpriteNodeProtocol] = []
  
  init(size: CGSize? = nil) {
    frame = CGRect(x: 1000, y: 500, width: 1000, height: 500)
    self.size = size ?? .zero
  }

  func addChild(_ node: SKNode) {
    children.append(node)
  }
  
  func addChild(_ node: SpriteNodeProtocol) {
    mockChildren.append(node)
  }
  
  func childNode(withName name: String) -> SKNode? {
    return children.first { $0.name == name }
  }
  
  func removeAction(forKey key: String) {
    // TODO: later
    //children.removeAll { $0.action(forKey: key) != nil }
    removeActionWasCalled = true
  }
  
  func enumerateChildNodes(withName name: String, using block: @escaping (SKNode, UnsafeMutablePointer<ObjCBool>) -> Void) {
    enumerateChildNodesWasCalled = true
  }
}
