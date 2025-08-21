//
//  SpriteNodeProtocol.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import SpriteKit

public protocol SpriteNodeProtocol: AnyObject {
  var runWasCalled: Bool { get set }
  var node: SKSpriteNode? { get }

  var position: CGPoint? { get set }
  var name: String? { get set }
  var zPosition: CGFloat { get set }
  
  func run(_ action: SKAction)
  func contains(_ p: CGPoint) -> Bool
  func removeFromParent()
}

public class SpriteNode: SpriteNodeProtocol {
  
  public var runWasCalled: Bool = false

  public var node: SKSpriteNode?
  
  public var position: CGPoint? {
    get { node?.position }
    set {
      guard let newPosition = newValue else { return }
      node?.position = newPosition
    }
  }

  public var name: String? {
    get { node?.name }
    set { node?.name = newValue }
  }
  
  public var zPosition: CGFloat {
    get { node?.zPosition ?? 0 }
    set { node?.zPosition = newValue }
  }

  public init(node: SKSpriteNode?) {
    self.node = node
  }
  
  public init(texture: SKTexture) {
    node?.texture = texture
  }
  
  public func run(_ action: SKAction) {
    self.runWasCalled = true
  }
  
  public func contains(_ p: CGPoint) -> Bool {
    node?.contains(p) ?? false
  }
  
  public func removeFromParent() {
    node?.removeFromParent()
  }
}
