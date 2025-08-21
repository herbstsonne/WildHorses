//
//  SceneNodeProtocol.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import SpriteKit

public protocol SceneNodeProtocol {
  var size: CGSize { get }
  var frame: CGRect { get }
  var children: [any SpriteNodeProtocol] { get }
  var camera: SKCameraNode? { get set }
  
  func addChild(_ node: any SpriteNodeProtocol)
  func addChild(_ node: any CameraNodeProtocol)
  func childNode(withName name: String) -> (any SpriteNodeProtocol)?
  func removeAction(forKey key: String)
  func enumerateChildNodes(withName name: String, using block: @escaping (SKNode, UnsafeMutablePointer<ObjCBool>) -> Void)
}

struct SceneNode: SceneNodeProtocol {

  var scene: SKScene

  var size: CGSize {
    scene.size
  }

  var frame: CGRect {
    scene.frame
  }

  var children: [any SpriteNodeProtocol] {
    scene.children.map { SpriteNode(node: $0 as? SKSpriteNode) }
  }

  var camera: SKCameraNode? {
    get {
      scene.camera
    }
    set {
      scene.camera = newValue
    }
  }
  
  func addChild(_ node: any SpriteNodeProtocol) {
    guard let node = node.node else { return }
    self.scene.addChild(node)
  }
  
  func addChild(_ node: any CameraNodeProtocol) {
    guard let camera = node.node else { return }
    self.scene.addChild(camera)
  }

  func childNode(withName name: String) -> (any SpriteNodeProtocol)? {
    let node = scene.childNode(withName: name)
    return SpriteNode(node: node as? SKSpriteNode)
  }
  
  func removeAction(forKey key: String) {
    scene.removeAction(forKey: key)
  }

  func enumerateChildNodes(withName name: String, using block: @escaping (SKNode, UnsafeMutablePointer<ObjCBool>) -> Void) {
    scene.enumerateChildNodes(withName: name, using: block)
  }
}
