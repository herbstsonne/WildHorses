//
//  NodeProtocol.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import SpriteKit

public protocol CameraNodeProtocol {
  var node: SKCameraNode? { get }

  var position: CGPoint { get set }
  
  func addChild(_ node: SKLabelNode)
}

public struct CameraNode: CameraNodeProtocol {

  public var node: SKCameraNode?

  public var position: CGPoint {
    get { node?.position ?? .zero }
    set { node?.position = newValue }
  }
  
  public init(node: SKCameraNode?) {
    self.node = node
  }

  public func addChild(_ node: SKLabelNode) {
    self.node?.addChild(node)
  }
}
