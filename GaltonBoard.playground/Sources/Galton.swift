import UIKit
import SpriteKit

public class Galton{
    let totalWidth = 450 //450
    let totalHeight = 800 //800
    let capDiameter : CGFloat = 30.0
    let pinDiameter : CGFloat = 24.0
    let levels = 5
    
    public init(){}
    
    func drawUpperTriangleIn(scene: GaltonScene){
        drawUpperTriangle(scene: scene, levels: levels)
    }
    
    func restartDropIn(scene: GaltonScene){
        var numberCaps = Int.random(in: 2...10)
        print("Dropping \(numberCaps) caps")
        dropRandomCapInScene(scene: scene)
        numberCaps = numberCaps-1

        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {
            (timer) in self.dropRandomCapInScene(scene: scene)
            numberCaps = numberCaps-1
            if(numberCaps==0){
                timer.invalidate()
            }
        })

    }

    func dropRandomCapInScene(scene: GaltonScene){
        let offset = CGFloat.random(in: -3...3)
        var center = positionAt(level: levels-1, ball: 1)
        center.x = center.x+offset
        scene.addSpriteAtPosition(point: center, color: .blue, isDynamic: true, radius: capDiameter/2)
    }

    func drawUpperTriangle(scene: GaltonScene, levels: Int){
        for i in 0...levels-2{ //for each level i
            let ballsInLvel = levels-i
            for j in 1...ballsInLvel{ //for each ball
                scene.addSpriteAtPosition(point: positionAt(level: i, ball: j), color: .black, isDynamic: false, radius: pinDiameter/2)
            }
        }
    }

    func positionAt(level: Int, ball:Int) -> CGPoint{
        let space = capDiameter*2
        let x = (CGFloat(ball)*(space))+(capDiameter*CGFloat(level))
        let y = (CGFloat(level)*(capDiameter*2))+capDiameter
        return CGPoint(x:x, y:y)
    }
}

