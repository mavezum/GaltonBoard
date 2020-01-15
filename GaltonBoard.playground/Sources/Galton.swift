import UIKit
import SpriteKit

public class Galton{
    let totalWidth = 450 //450
    let totalHeight = 450 //800
    let capDiameter : CGFloat = 30.0
    let levels = 5
    
    public init(){}
    
    func drawUpperTriangleIn(scene: GaltonScene){
        drawUpperTriangle(scene: scene, levels: levels, space: capDiameter*2)
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
        let offset = Int.random(in: -3...3)
        let center = CGPoint(x:180+offset, y:270)
        scene.addSpriteAtPosition(point: center, color: .blue, isDynamic: true, radius: capDiameter/2)
    }

    func drawUpperTriangle(scene: GaltonScene, levels: Int, space:CGFloat){
        for i in 0...levels-2{ //for each level i
            let ballsInLvel = levels-i
            for j in 1...ballsInLvel{ //for each ball
                scene.addSpriteAtPosition(point: CGPoint(x: (CGFloat(j)*(space))+(capDiameter*CGFloat(i)),
                                                   y: (CGFloat(i)*(capDiameter*2))+capDiameter), color: .black, isDynamic: false, radius: 12)
            }
        }
    }

}

