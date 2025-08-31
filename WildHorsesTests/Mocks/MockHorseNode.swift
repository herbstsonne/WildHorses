import SpriteKit
import WildHorses

final class MockHorseNode: SpriteNodeProtocol {

  var position: CGPoint = .zero
  
  var name: String?
  
  var zPosition: CGFloat = 0.0
  
  var didRunAction = false
  var didRemoveFromParent = false
  
  func run(_ action: SKAction) {
    didRunAction = true
  }
  
  func removeFromParent() {
    didRemoveFromParent = true
  }
  
  var shouldContainPoint = false
  func contains(_ p: CGPoint) -> Bool {
    return shouldContainPoint
  }
}
