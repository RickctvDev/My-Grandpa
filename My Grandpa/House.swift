//
//  House.swift
//  My Grandpa
//
//  Created by Rick Crane on 01/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class House : SpriteCreator {
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    private let audioSource = AudioMaker()
    
    private let houseXScale : CGFloat = 0.2
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        _scene = scene
        _texture = texture
        _zPosition = 4
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name: _name)
        self.xScale = houseXScale
        self.yScale = self.xScale
        self.position = CGPoint(x: scene.frame.minX + self.frame.size.width / 2 - 50, y: scene.frame.minY + 40)
        
        if itIsDayTime == false {
            self.color = nightColor
            self.colorBlendFactor = nightBlendValue
        }
    }
    
    private func sleepingAction(){
        let fadeDuration : Double = 5
        
        let zText = SKLabelNode(text: "Z")
        zText.fontSize = 5
        zText.fontName = "AvenirNext-Bold"
        zText.fontColor = .black
        zText.zPosition = self.zPosition + 1
        zText.position = CGPoint(x: self.frame.maxX - 65, y: self.frame.midY)
        
        let action = SKAction.moveBy(x: 2, y: 2, duration: 0.1)
        let reapeatForever = SKAction.repeatForever(action)
        
        let rotate = SKAction.rotate(byAngle: 0.1, duration: 0.3)
        let seq = SKAction.sequence([rotate, rotate.reversed()])
        let rotateForever = SKAction.repeatForever(seq)
        
        let fontGrow = SKAction.scale(to: 5, duration: fadeDuration)
        
        let fade = SKAction.fadeAlpha(to: 0, duration: fadeDuration)
        
        _scene.addChild(zText)
        zText.run(reapeatForever)
        zText.run(rotateForever)
        zText.run(fontGrow)
        zText.run(fade) {
            zText.removeAllActions()
            zText.removeFromParent()
        }
    }
    
    func makeSleep(){
        var counter = 1
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            if counter %  4 == 0 {
                
            } else {
                self.sleepingAction()
            }
            counter += 1
        }
    }
    
    func openAndCloseHouse(waitForDuration : Double){
        let wait = SKAction.wait(forDuration: waitForDuration)
        let point = CGPoint(x: self.anchorPoint.x, y: self.anchorPoint.y)
        let bgHouse = SpriteCreator(scene: _scene, texture: "HouseOpen", zPosition: self.zPosition - 1, anchorPoints:  point, name: nil)
        bgHouse.xScale = self.xScale
        bgHouse.yScale = bgHouse.xScale
        bgHouse.position = self.position
        self._scene.addChild(bgHouse)
    
        self.run(wait) {
            
            self.texture = SKTexture(imageNamed: "HouseOpenNoDoor")
            self.audioSource.playASound(scene: self._scene, fileNamed: "OpenDoorSoundEffect", atVolume: 0.1)
            
            self.run(SKAction.wait(forDuration: 1), completion: {
                self.texture = SKTexture(imageNamed: "house")
                self.audioSource.playASound(scene: self._scene, fileNamed: "CloseDoorSoundEffect", atVolume: 0.1)
                bgHouse.removeFromParent()
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
