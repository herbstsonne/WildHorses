import Testing
import SpriteKit
@testable import WildHorses

@Suite("PlayerCamera Tests")
struct PlayerCameraTests {
    
    @Test("setup attaches camera to scene and centers it")
    func test_setup() {
        var scene = MockScene(size: CGSize(width: 200, height: 400))
        var camera = PlayerCamera(scene: scene)
        
        camera.setup()
        
        #expect(scene.camera != nil)
        #expect(scene.camera?.position == CGPoint(x: 100, y: 200))
        #expect(scene.children.contains(where: { $0 === scene.camera }))
    }
    
    @Test("add attaches score label to camera and configures properties")
    func test_add_scoreLabel() {
        var scene = MockScene(size: CGSize(width: 200, height: 400))
        var camera = PlayerCamera(scene: scene)
        camera.setup()
        
        let label = SKLabelNode()
        let gameState = GameState()
        gameState.score = 42
        
        camera.add(scoreLabel: label, gameState: gameState)
        
        #expect(label.text == "Points: 42")
        #expect(label.horizontalAlignmentMode == .right)
        #expect(label.verticalAlignmentMode == .top)
        #expect(label.parent === scene.camera)
    }
    
    @Test("alignWithPlayer moves camera to player's x position")
    func test_alignWithPlayer() {
        var scene = MockScene(size: CGSize(width: 200, height: 400))
        var camera = PlayerCamera(scene: scene)
        camera.setup()
        
        let player = MockSpriteNode()
        player.position = CGPoint(x: 150, y: 50)
        
        camera.alignWithPlayer(playerNode: player)
        
        #expect(scene.camera?.position.x == 150)
        #expect(scene.camera?.position.y == 200) // fixed center vertically
    }
}
