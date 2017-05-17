//
//  SpriteCreator.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class SpriteCreator: SKSpriteNode {
    init(scene : SKScene, texture : String, zPosition : CGFloat, anchorPoints : CGPoint?, name : String?) {
        let textureToMake = SKTexture(imageNamed: texture)
        
        super.init(texture: textureToMake , color: UIColor.clear, size: textureToMake.size())
        
        if anchorPoints == nil {
            self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }else{
            self.anchorPoint = anchorPoints!
        }
        self.zPosition = zPosition
        
        if name == nil {
            self.name = texture
        }else{
            self.name = name
        }
    }
    
    init(scene : SKScene, texture : String, zPosition : CGFloat, anchorPoints : CGPoint?, name : String?, downFromSpriteNamed : String?){
        let textureToMake = SKTexture(imageNamed: texture)
        let firstSpriteStartPos : CGFloat = 40
        let spaceBelowOtherSprites : CGFloat = 25
        
        super.init(texture: textureToMake , color: UIColor.clear, size: textureToMake.size())
        self.xScale = 0.3
        self.yScale = self.xScale
        self.zPosition = 11
        self.name = name
        
        if downFromSpriteNamed == nil {
            self.position = CGPoint(
                x: scene.frame.maxX + self.frame.size.width,
                y: scene.frame.midY + firstSpriteStartPos)
        }else{
            self.position = CGPoint(
                x: scene.frame.maxX + self.frame.size.width,
                y: ((scene.childNode(withName: downFromSpriteNamed!)?.frame.minY)! - spaceBelowOtherSprites))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
