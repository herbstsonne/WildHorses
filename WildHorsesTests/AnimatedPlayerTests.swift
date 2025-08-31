import SpriteKit
import Testing
@testable import WildHorses

@Suite("AnimatedPlayer Tests")
struct AnimatedPlayerTests {

  @Test("setup positions player correctly")
  func testSetupPositionsPlayerCorrectly() {
    let scene = MockScene()
    let settings = Settings()
    var player = AnimatedPlayer(scene: scene, gameState: GameState(), settings: settings)
    let sprite: SpriteNodeProtocol = MockSpriteNode()
    
    player.setup(playerNode: sprite)
    
    #expect(sprite.position == CGPoint(x: scene.frame.midX, y: scene.frame.minY + 20))
    #expect(sprite.name == "player")
    #expect(sprite.zPosition == 2)
    #expect(scene.children.contains { $0 === sprite as? SKNode })
  }
    
  @Test("run adds move action")
  func testRunAddsMoveAction() {
    let scene = MockScene()
    let settings = Settings()
    var player = AnimatedPlayer(scene: scene, gameState: GameState(), settings: settings)
    let sprite = SKSpriteNode()
    sprite.name = "player"
    scene.addChild(sprite)
    
    let start = CGPoint(x: 0, y: 0)
    let target = CGPoint(x: 50, y: 50)
    player.run(startPosition: start, targetPosition: target)
        
    #expect(sprite.hasActions())
  }
    
  @Test("calculateAnimation adds frames and action")
  func testCalculateAnimationAddsFramesAndAction() {
    let scene = MockScene()
    let settings = Settings()
    var player = AnimatedPlayer(scene: scene, gameState: GameState(), settings: settings)
    let sprite = SKSpriteNode()
    sprite.name = "player"
    scene.addChild(sprite)
    
    let start = CGPoint(x: 0, y: 0)
    let target = CGPoint(x: 10, y: 10)
    
    player.calculateAnimation(startPosition: start, targetPosition: target)
        
    #expect(sprite.action(forKey: "repeatedAnimation") != nil)
  }
}
