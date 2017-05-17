//
//  Sun.swift
//  My Grandpa
//
//  Created by Rick Crane on 01/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Sun : SpriteCreator {
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?,  name: String?) {
        _scene = scene
        _texture = texture
        _zPosition = 2
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name: _name)
        
        self.xScale = 0.1
        self.yScale = self.xScale
        self.position = CGPoint(x: scene.frame.minX + 20, y: scene.frame.maxY - 40)
        
        sunAnimation()
    }
    
    private func sunAnimation(){
        let sunMoveAction = SKAction.rotate(byAngle: -0.4, duration: 1)
        let sunActionForever = SKAction.repeatForever(sunMoveAction)
        self.run(sunActionForever)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
