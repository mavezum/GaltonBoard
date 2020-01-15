import UIKit
import SpriteKit
import PlaygroundSupport

let totalWidth = 450 //450
let totalHeight = 450 //800
let capDiameter : CGFloat = 30.0

class GaltonScene : SKScene {
    
    override init() {
        super.init(size: CGSize(width: totalWidth, height: totalWidth))
        self.scaleMode = .resizeFill
        self.backgroundColor = .white
        
        drawUpperTriangleFor(levels: 5, space:capDiameter*2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        restartDrop();
    }
    
    func restartDrop(){
        var numberCaps = Int.random(in: 2...10)
        numberCaps = numberCaps-1
        print("Dropping \(numberCaps) caps")
        self.dropRandomCap()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {
            (timer) in self.dropRandomCap()
            numberCaps = numberCaps-1
            if(numberCaps==0){
                timer.invalidate()
            }
        })
    
    }
    
    func dropRandomCap(){
        let offset = Int.random(in: -3...3)
        let center = CGPoint(x:180+offset, y:270)
        addSpriteAtPosition(point: center, color: .blue, isDynamic: true, radius: capDiameter/2)
    }
    
    func drawUpperTriangleFor(levels: Int, space:CGFloat){
        for i in 0...levels-2{ //for each level i
            let ballsInLvel = levels-i
            for j in 1...ballsInLvel{ //for each ball
                addSpriteAtPosition(point: CGPoint(x: (CGFloat(j)*(space))+(capDiameter*CGFloat(i)),
                                                   y: (CGFloat(i)*(capDiameter*2))+capDiameter), color: .black, isDynamic: false, radius: 12)
            }
        }
    }

    func addSpriteAtPosition(point: CGPoint, color: UIColor, isDynamic: Bool, radius: CGFloat){
        let tile = SKShapeNode(circleOfRadius: radius);
        tile.fillColor = color
        let shapeTexture = SKView().texture(from: tile)

        let sprite = SKSpriteNode(texture: shapeTexture)
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: capDiameter/2)
        sprite.physicsBody?.isDynamic = isDynamic;
        sprite.physicsBody?.mass = 1
        sprite.position = point
        self.addChild(sprite)
    }
}

class ViewController : UIViewController {
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.preferredContentSize = CGSize(width: totalWidth, height: totalHeight)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        self.preferredContentSize = CGSize(width: totalWidth, height: totalHeight)
        let view = SKView()
        view.presentScene(GaltonScene())
        self.view = view

    }
}
PlaygroundPage.current.liveView = ViewController()

