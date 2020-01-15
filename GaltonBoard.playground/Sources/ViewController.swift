import UIKit
import SpriteKit

public class GaltonScene : SKScene {
    
    var galton : Galton
    
    init(galton: Galton) {
        self.galton = galton
        super.init(size: CGSize(width: galton.totalWidth, height: galton.totalHeight))
        self.scaleMode = .resizeFill
        self.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        galton.restartDropIn(scene: self);
    }
    
    public func addSpriteAtPosition(point: CGPoint, color: UIColor, isDynamic: Bool, radius: CGFloat){
        let tile = SKShapeNode(circleOfRadius: radius);
        tile.fillColor = color
        let shapeTexture = SKView().texture(from: tile)

        let sprite = SKSpriteNode(texture: shapeTexture)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        sprite.physicsBody?.isDynamic = isDynamic;
        sprite.physicsBody?.mass = 1
        sprite.position = point
        self.addChild(sprite)
    }
}

public class ViewController : UIViewController {
    
    var galton : Galton
    var galtonScene : GaltonScene
    
    public init(galton: Galton){
        self.galton = galton;
        self.galtonScene = GaltonScene(galton: galton)

        super.init(nibName: nil, bundle: nil)
        self.preferredContentSize = CGSize(width: self.galton.totalWidth, height: self.galton.totalHeight)
        galton.drawUpperTriangle(scene: galtonScene)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func loadView() {
        let view = SKView()
        view.presentScene(galtonScene)
        self.view = view

    }
}
