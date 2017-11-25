//
//  Ground.swift
//  My Grandpa
//
//  Created by Rick Crane on 01/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Ground : SpriteCreator{
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        
        _scene = scene
        _texture = texture
        _zPosition = 5
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name : _name)
        
        self.size = CGSize(width: scene.frame.size.width + 50, height: 50)
        self.position = CGPoint(x: scene.frame.midX, y: scene.frame.minY)
        
        if itIsDayTime == false {
            self.color = nightColor
            self.colorBlendFactor = nightBlendValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
