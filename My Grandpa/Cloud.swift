//
//  Cloud.swift
//  My Grandpa
//
//  Created by Rick Crane on 01/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Cloud : SpriteCreator, Updatable {
    
    private let _sizeOfImage : CGFloat = 0.4
    private let cloudTextureArray = ["Cloud1", "Cloud2", "Cloud3"]
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    private let durationToMove : Double = 1.5
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        _scene = scene
        _texture = texture
        _zPosition = 3
        _anchorPoint = anchorPoints
        _name = name
        
        //Randomly Choose a Cloud Image to display
        let randomNumGen = Int(arc4random_uniform(3))
        let cloudTexturePicked = cloudTextureArray[randomNumGen]
        
        super.init(scene: _scene, texture: cloudTexturePicked, zPosition: _zPosition, anchorPoints: _anchorPoint, name: _name)
            //Position The Sprite
            self.xScale = _sizeOfImage
            self.yScale = self.xScale
        
            let xPos = scene.frame.maxX + self.frame.size.width
            let maxYPos = scene.frame.maxY
            let minYPos = scene.frame.midY
            let finalYPos = randomPointsBetweenWithFloat(firstNum: minYPos, secondNum: maxYPos)
        
            self.position = CGPoint(x: xPos, y: finalYPos)
        
            moveCloudsAnimation()
    }
    
    private func moveCloudsAnimation(){
        let moveLeft = SKAction.moveBy(x: -20, y: 0, duration: durationToMove)
        let moveforever = SKAction.repeatForever(moveLeft)
        self.run(moveforever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: TimeInterval) {
        if self.position.x < (scene?.frame.minX)! - 50{
            //reposition
            let xPos = (scene?.frame.maxX)! + self.frame.size.width
            let maxYPos = scene?.frame.maxY
            let minYPos = scene?.frame.midY
            let finalYPos = randomPointsBetweenWithFloat(firstNum: minYPos!, secondNum: maxYPos!)
            self.position = CGPoint(x: xPos, y: finalYPos)
        }
    }
}
