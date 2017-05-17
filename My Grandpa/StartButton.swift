//
//  StartButton.swift
//  My Grandpa
//
//  Created by Rick Crane on 02/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class StartButton : SpriteCreator {
    
    private let createGrandpaImage = "createNewGrandpa"
    private let continueGameImage = "continueGame" // TO BE USED AFTER FINDING USER PREVIOUS SAVE
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    
    private let fadeInTimer : Double = 1.5
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        
        _scene = scene
        _texture = texture
        _zPosition = 7
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name : _name)
        
        if itIsDayTime == false {
            self.color = nightColor
            self.colorBlendFactor = nightBlendValue
        }
        
        self.xScale = 0.4
        self.yScale = self.xScale
        self.position = CGPoint(x: _scene.frame.midX, y: _scene.frame.midY)
        
        self.run(SKAction.fadeIn(withDuration: fadeInTimer))
    }
    
    func startGameButtonPressed(nodePressed: SKNode, camNode : Camera?){
        
        if nodePressed.name == continueGameButtonName {
            print("CONTINUING THE GAME")
            moveAndRemoveStartButton()
            
        }else if nodePressed.name == createNewGrandpaButtonName {
            print("CREATING NEW GRANDPA")
            moveAndRemoveStartButton()
            createNewPressedSetup(cam: camNode!)
        }
        
    }
    
    private func createNewPressedSetup(cam : Camera){
        if let houseFind = _scene.childNode(withName: houseName) {
            if let groundFind = self._scene.childNode(withName: groundName) {
                cam.moveToPos(position: CGPoint(x: _scene.frame.minX + houseFind.frame.size.width / 1.2,
                                                y: groundFind.frame.maxY / 2),
                              withTime: 0.5,
                              withZoom: 0.5)
            }
        }
    }
    
    func moveAndRemoveStartButton(){
        self.isUserInteractionEnabled = false
        let removeButton = SKAction.moveTo(y: (scene?.frame.maxY)! + self.frame.size.height, duration: 0.4)
        self.run(removeButton) {
            self.removeFromParent()
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
