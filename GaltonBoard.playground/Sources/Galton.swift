import UIKit
import SpriteKit

public class Galton{
    let totalWidth = 450 //450
    let totalHeight = 800 //800
    let capDiameter : CGFloat = 30.0
    let pinDiameter : CGFloat = 24.0
    let levels = 5
    let centerX : CGFloat
    let centerY : CGFloat
    
    public init(){
        self.centerX = (capDiameter*2)+(capDiameter*CGFloat(levels))
        let topBall = (CGFloat(levels)*(capDiameter*2))+capDiameter
        self.centerY = CGFloat(totalHeight) - topBall - capDiameter
    }
    
    func positionAt(level: Int, ball:Int) -> CGPoint{
        let x = (CGFloat(ball-1)*(capDiameter*2))+(capDiameter*CGFloat(level)) + centerX/2// + capDiameter/2
        let y = (CGFloat(level)*(capDiameter*2))+capDiameter + centerY
        return CGPoint(x:x, y:y)
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
        var center = positionAt(level: levels, ball: 1)
        center.x = center.x+offset-capDiameter
        scene.addSpriteAtPosition(point: center, isDynamic: true, radius: capDiameter/2)
    }

    func drawUpperTriangle(scene: GaltonScene){
        for i in 1...levels{ //for each level i
            let ballsInLvel = levels-i+1
            for j in 0...ballsInLvel{ //for each ball
                var point = positionAt(level: i, ball: j)
                point.y = point.y-capDiameter*2
                scene.addSpriteAtPosition(point: point, isDynamic: false, radius: pinDiameter/2)
            }
        }
    }
    
    func drawLowerSticksAndFloorInScene(scene: GaltonScene){
        //position at level 0 ball 1..5 vai me dar a posicao das ultimas bolas
        let wallHeight = centerY - capDiameter
        let wallWidth : CGFloat = 15.0
        
        for i in 0...levels {
            let horizontalPosition = positionAt(level: 0, ball: i)
            scene.addWall(width: wallWidth, height: wallHeight, position: horizontalPosition.x+capDiameter)
        }
        scene.addFloorWithWidth(width:CGFloat(totalWidth), height:wallWidth)

    }


}

