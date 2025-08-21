//
//  SceneNodeProtocol.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 20.08.25.
//

import SpriteKit

public protocol SceneNodeProtocol: AnyObject {
  var size: CGSize { get }
  var frame: CGRect { get }
  var children: [SKNode] { get }
  var camera: SKCameraNode? { get set }
  
  func addChild(_ node: SKNode)
  func childNode(withName name: String) -> (SKNode)?
  func removeAction(forKey key: String)
  func enumerateChildNodes(withName name: String, using block: @escaping (SKNode, UnsafeMutablePointer<ObjCBool>) -> Void)
}

extension SKScene: SceneNodeProtocol {}
