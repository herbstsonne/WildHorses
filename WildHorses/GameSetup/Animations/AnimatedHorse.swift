import SpriteKit

public protocol HorseAnimatable {
  var horses: [SpriteNodeProtocol] { get set }
  var catchedHorses: Int { get }
  
  mutating func setup() throws
  mutating func addMoreHorses(camera: SKCameraNode) throws
  mutating func run(startPosition: CGPoint, horseNode: SpriteNodeProtocol) throws
  mutating func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode)
}

struct AnimatedHorse: HorseAnimatable {
  
  var horses: [SpriteNodeProtocol] = []
  var catchedHorses: Int = 0

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
  
  mutating func setup() throws {
    guard let parentNode = scene else { return }

    for _ in 0..<settings.numberOfHorses {
      let horseNode = SKSpriteNode(texture: SKTexture(imageNamed: "horse_run0"), color: .blue, size: CGSize(width: 100, height: 100))
      try run(
        startPosition: CGPoint(x: Double.random(in: parentNode.frame.maxX + 50...parentNode.frame.maxX + 700), y: Double.random(in: parentNode.frame.minY + 50...parentNode.frame.maxY - 250)),
        horseNode: horseNode
      )
    }
  }

  mutating func addMoreHorses(camera: SKCameraNode) throws {
    guard let parentNode = scene else { return }

    for _ in 0..<settings.numberOfHorses {
      let horseNode = SKSpriteNode(texture: SKTexture(imageNamed: "horse_run0"), color: .blue, size: CGSize(width: 100, height: 100))
      try run(
        startPosition: CGPoint(x: Double.random(in: parentNode.size.width + camera.position.x...parentNode.size.width + camera.position.x + 500), y: Double.random(in: parentNode.frame.minY + 50...parentNode.frame.maxY - 250)),
          horseNode: horseNode
        )
    }
  }

  mutating func run(startPosition: CGPoint, horseNode: SpriteNodeProtocol) throws {
    guard let horseNode = horseNode as? SKSpriteNode else { return }
    horseFrames = collectHorseFrames()
    horseNode.position = startPosition
    horseNode.name = "horse"
    horses.append(horseNode)
    scene?.addChild(horseNode)
  
    horseNode.run(SKAction.repeatForever(SKAction.animate(with: horseFrames, timePerFrame: 0.1)))

    let moveAction = SKAction.moveBy(x: -1000, y: 0, duration: settings.speed)
    let repeatForever = SKAction.repeatForever(moveAction)
    horseNode.run(repeatForever)
  }
  
  mutating func caught(touchLocation: CGPoint, pointsLabel: SKLabelNode) {
    guard let parentNode = scene else { return }

    for horse in horses {
      if horse.contains(touchLocation) {
        if parentNode.children.contains(where: {
            $0 == horse as? SKSpriteNode
        })
        {
          print("Catched a horse")
          horse.removeFromParent()
          gameState.score += 1
          catchedHorses += 1
          pointsLabel.text = "Punkte: \(gameState.score)"
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
