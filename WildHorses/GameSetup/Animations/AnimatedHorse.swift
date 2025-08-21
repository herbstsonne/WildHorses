import SpriteKit

protocol HorseAnimatable {
  var horses: [SpriteNodeProtocol] { get set }
  
  mutating func setup(horseNodes: [SpriteNodeProtocol]) throws
  mutating func run(startPosition: CGPoint, horseNode: SpriteNodeProtocol) throws
  func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode)
}

struct AnimatedHorse: HorseAnimatable {
  
  var horses: [SpriteNodeProtocol] = []

  private var gameState: GameState
  private let settings: Settings
  private var scene: SceneNodeProtocol?
  private var horseFrames: [SKTexture] = []
  
  init(
    scene: SceneNodeProtocol?,
    gameState: GameState,
    settings: Settings
  ) {
    self.gameState = gameState
    self.settings = settings
    self.scene = scene
  }
  
  mutating func setup(horseNodes: [SpriteNodeProtocol]) throws {
    guard let parentNode = scene else { return }

    if horseNodes.count != settings.numberOfHorses {
      fatalError("Wrong number of horse nodes")
    }

    for num in 0..<settings.numberOfHorses {
      try run(
        startPosition: CGPoint(x: 700, y: Double.random(in: parentNode.frame.minY + 50...parentNode.frame.maxY - 200)),
        horseNode: horseNodes[num]
      )
    }
  }

  mutating func run(startPosition: CGPoint, horseNode: SpriteNodeProtocol) throws {
    horseFrames = collectHorseFrames()
    horseNode.position = startPosition
    horseNode.name = "horse"
    horses.append(horseNode)
    scene?.addChild(horseNode as! SKSpriteNode)
  
//    horseNode.run(SKAction.repeatForever(SKAction.animate(with: horseFrames, timePerFrame: 0.1)))
//
//    let moveAction = SKAction.moveBy(x: -1000, y: 0, duration: settings.speed)
//    let repeatForever = SKAction.repeatForever(moveAction)
//    horseNode.run(repeatForever)
  }
  
  func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode) {
    guard let parentNode = scene else { return }

    for horse in horses {
      if horse.contains(touchLocation) {
        if parentNode.children.contains(where: {
          $0 == horse as! SKSpriteNode
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

  private mutating func collectHorseFrames() -> [SKTexture] {
    let horseAtlas = SKTextureAtlas(named: "Horse")
    let numImages = horseAtlas.textureNames.count
    
    for i in 0...numImages - 1 {
      let textureName = "horse_run\(i)"
      horseFrames.append(horseAtlas.textureNamed(textureName))
    }
    return horseFrames
  }
}
