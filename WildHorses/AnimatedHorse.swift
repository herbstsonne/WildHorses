import SpriteKit

struct AnimatedHorse {
  
  var horses: [SKSpriteNode] = []
  var parentNode: SKNode?

  private var gameState: GameState
  private var horseFrames: [SKTexture] = []
  private let horseAtlas: SKTextureAtlas?
  private let numImages: Int
  
  init(gameState: GameState) {
    self.gameState = gameState
    horseAtlas = SKTextureAtlas(named: "Horse")
    numImages = horseAtlas?.textureNames.count ?? 0
  }
  
  mutating func run(startPosition: CGPoint) {
    guard let horseAtlas = horseAtlas else { return }
    for i in 0...numImages - 1 {
      let textureName = "horse_run\(i)"
      horseFrames.append(horseAtlas.textureNamed(textureName))
    }
    
    // Create sprite node
    let horse = SKSpriteNode(texture: horseFrames[0])
    horse.position = startPosition
    horse.name = "horse"
    horses.append(horse)
    parentNode?.addChild(horse)
    
    // Run animation
    horse.run(SKAction.repeatForever(SKAction.animate(with: horseFrames, timePerFrame: 0.1)))
    // Move across screen
    let moveAction = SKAction.moveTo(x: -100, duration: 20)
    horse.run(moveAction)
  }
  
  func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode) {
    guard let parentNode = parentNode else { return }

    for horse in horses {
      if horse.contains(touchLocation) {
        if parentNode.children.contains(where: {
          $0 == horse
        })
        {
          print("hit")
          horse.removeFromParent()
          gameState.score += 1
          pointsLabel.text = "Points: \(gameState.score)"
        }
      }
    }
  }
}
