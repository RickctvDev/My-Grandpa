//
//  Star.swift
//  My Grandpa
//
//  Created by Rick Crane on 01/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Star : SpriteCreator {
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    
    private let starXScale : CGFloat = 0.01
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name : String?) {
        
        _scene = scene
        _texture = texture
        _zPosition = 1
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name: _name)
        
        self.xScale = starXScale
        self.yScale = self.xScale
        self.alpha = 0
    }
    
    func makeStarsAnimation(){
        let minToMaxX = randomPointsBetweenWithFloat(firstNum: (scene?.frame.minX)!, secondNum: (scene!.frame.maxX))
        let minToMaxY = randomPointsBetweenWithFloat(firstNum: (scene?.frame.midY)! - 20, secondNum: (scene?.frame.maxY)!)
        self.position = CGPoint(x: minToMaxX, y: minToMaxY)
        
        let smallestTime : Double = 2
        let longestTime : Double = 5
        let animFadeOut = SKAction.fadeAlpha(to: 0, duration: randomBetweenNumbersDouble(firstNum: smallestTime, secondNum: longestTime))
        let animFadeIn = SKAction.fadeAlpha(to: 0.6, duration: randomBetweenNumbersDouble(firstNum: smallestTime, secondNum: longestTime))
        let seq = SKAction.sequence([animFadeIn, animFadeOut])
        let forever = SKAction.repeatForever(seq)
        self.run(forever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
