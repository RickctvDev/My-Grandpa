//
//  DebugMenu.swift
//  My Grandpa
//
//  Created by Rick Crane on 02/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class DebugMenu : SpriteCreator {
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    
    
    override init(scene: SKScene, texture: String?, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        
        _scene = scene
        _texture = texture
        _zPosition = 5
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name: _name)
        
        if debugMode == true {
            self.zPosition = _zPosition
            self.name = _name
            self.size = CGSize(width: 60, height: 25)
            self.color = UIColor.brown
            
            let xPos = _scene.frame.maxX - self.frame.size.width / 2 - 5
            let yPos = _scene.frame.maxY - self.frame.size.height
            self.position = CGPoint(x: xPos, y: yPos)
            
            let label = SKLabelNode(text: "Debug")
            label.fontSize = 15
            label.name = debugButtonName
            label.fontName = "AvenirNext-Bold"
            label.position.y = label.position.y - 4
            label.fontColor = UIColor.black
            label.zPosition = self.zPosition + 1
            
            _scene.addChild(self)
            self.addChild(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
