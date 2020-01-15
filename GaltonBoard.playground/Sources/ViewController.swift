import UIKit
import SpriteKit

public class GaltonScene : SKScene {
    
    var galton : Galton
    let wallColor = UIColor.brown
    
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
    
    public func addSpriteAtPosition(point: CGPoint, isDynamic: Bool, radius: CGFloat){
        let tile = SKShapeNode(circleOfRadius: radius);
        tile.fillColor = isDynamic ? .blue : wallColor

        let sprite = SKSpriteNode(texture: SKView().texture(from: tile))
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        sprite.physicsBody?.isDynamic = isDynamic;
        sprite.physicsBody?.mass = 1
        sprite.position = point
        self.addChild(sprite)
    }
    
    public func addWall(width: CGFloat, height: CGFloat, position: CGFloat){
        let yPosition : CGFloat = 5;
        
        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: height));
        node.fillColor = wallColor
        let sprite = SKSpriteNode(texture: SKView().texture(from: node))
        sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: -1, y: -1))
        sprite.physicsBody?.isDynamic = false
        sprite.position = CGPoint(x:position, y: yPosition+(height/2))
        self.addChild(sprite)
    }
    
    public func addFloorWithWidth(width:CGFloat, height:CGFloat){
        let yPosition : CGFloat = 5;
        let node = SKShapeNode(rect: CGRect(x: 0, y: 0, width: width, height: height));
        node.fillColor = wallColor
        let sprite = SKSpriteNode(texture: SKView().texture(from: node))
        sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height), center: CGPoint(x: -1, y: -1))
        sprite.physicsBody?.isDynamic = false
        sprite.position = CGPoint(x:5+width/2, y: yPosition)
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
        galton.drawLowerSticksAndFloorInScene(scene: galtonScene)

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
