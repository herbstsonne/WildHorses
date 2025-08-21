//
//  SpriteNodeProtocol.swift
//  WildHorses
//
//  Created by Miriam Pfaffenbach on 21.08.25.
//

import SpriteKit

public protocol SpriteNodeProtocol: AnyObject {

  var position: CGPoint { get set }
  var name: String? { get set }
  var zPosition: CGFloat { get set }
  
  func run(_ action: SKAction)
  func contains(_ p: CGPoint) -> Bool
  func removeFromParent()
}

extension SKNode: SpriteNodeProtocol, CameraNodeProtocol {}
