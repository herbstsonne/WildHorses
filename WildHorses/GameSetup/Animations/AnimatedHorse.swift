import SpriteKit

protocol HorseAnimatable {
  var horses: [SpriteNodeProtocol] { get set }
  
  mutating func setup()
  mutating func run(startPosition: CGPoint)
  func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode)
}

struct AnimatedHorse: HorseAnimatable {
  
  var horses: [SpriteNodeProtocol] = []

  private var gameState: GameState
  private let settings: Settings
  private var scene: SceneNodeProtocol?
  private var horseNode: SpriteNodeProtocol?
  private var horseFrames: [SKTexture]
  
  init(scene: SceneNodeProtocol?, horseNode: SpriteNodeProtocol?, gameState: GameState, settings: Settings, horseFrames: [SKTexture] = []) {
    self.gameState = gameState
    self.settings = settings
    self.scene = scene
    self.horseNode = horseNode
    self.horseFrames = horseFrames
  }
  
  mutating func setup() {
    guard let parentNode = scene else { return }

    for _ in 0..<settings.numberOfHorses {
      run(startPosition: CGPoint(x: 700, y: Double.random(in: parentNode.frame.minY + 50...parentNode.frame.maxY - 200)))
    }
  }

  mutating func run(startPosition: CGPoint) {
    guard let horseNode = horseNode else { return }

    horseNode.position = startPosition
    horseNode.name = "horse"
    horses.append(horseNode)
    scene?.addChild(horseNode)
    
    // Run animation
    horseNode.run(SKAction.repeatForever(SKAction.animate(with: horseFrames, timePerFrame: 0.1)))
    // Move across screen
    let moveAction = SKAction.moveBy(x: -1000, y: 0, duration: settings.speed)
    let repeatForever = SKAction.repeatForever(moveAction)
    horseNode.run(repeatForever)
  }
  
  func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode) {
    guard let parentNode = scene else { return }

    for horse in horses {
      if horse.contains(touchLocation) {
        if parentNode.children.contains(where: {
          $0.node == horse.node
        })
        {
          print("Catched a horse")
          horse.removeFromParent()
          gameState.score += 1
          pointsLabel.text = "Points: \(gameState.score)"
        }
      }
    }
  }
}
