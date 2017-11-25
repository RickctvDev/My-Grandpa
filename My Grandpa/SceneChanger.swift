//
//  SceneChanger.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/11/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class SceneChanger : SpriteCreator {
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    private let audio = AudioMaker()
    
    private let arrowXScale : CGFloat = 0.10
    private let arrowOffset : CGFloat = 4
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name : String?) {
        _scene = scene
        _texture = texture
        _zPosition = 4
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: "arrowLeft", zPosition: _zPosition, anchorPoints: _anchorPoint, name : _name)
        
        self.xScale = arrowXScale
        self.yScale = self.xScale
        self.zPosition = zPosition
        self.name = sceneChangeArrowLeftName
        self.position = CGPoint(x: scene.frame.minX + self.frame.size.width - arrowOffset, y: scene.frame.midY)
        
        let rightArrow = SpriteCreator(scene: scene, texture: "arrow", zPosition: self.zPosition, anchorPoints: nil, name: sceneChangeArrowRightName)
        rightArrow.scale(to: self.size)
        rightArrow.position = CGPoint(x: scene.frame.maxX - rightArrow.frame.size.width + arrowOffset, y: scene.frame.midY)
        scene.addChild(rightArrow)
        
        if scene.name == layoutOfHouseArray.first{
            self.isHidden = true
        }else if scene.name == layoutOfHouseArray.last{
            rightArrow.isHidden = true
        }
        
        _scene.childNode(withName: sceneChangeArrowRightName)?.alpha = 0
        self.alpha = 0
        
    }
    
    func enableTouchEventsOnArrowControls(){
        let waitAction = SKAction.wait(forDuration: 1)
        _scene.run(waitAction) {
            self._scene.childNode(withName: sceneChangeArrowRightName)?.run(SKAction.fadeIn(withDuration: 0.2))
            self.run(SKAction.fadeIn(withDuration: 0.2))
        }
    }
    
    func rightArrowTapped(moveWithDuration : Double){
        movedFromAnotherScene = true
        movedToSceneFromLeftArrowTouched = false
        
        audio.playButtonClickSound(scene: _scene, atVolume: defaultSoundVolume)
        
        _scene.childNode(withName: sceneChangeArrowRightName)?.removeFromParent()
        _scene.childNode(withName: sceneChangeArrowLeftName)?.removeFromParent()
        
        let duration : Double = moveWithDuration
        
        let wait = SKAction.wait(forDuration: duration)
        if let grandpa = _scene.childNode(withName: grandpaName) as? Grandpa{
            grandpa.removeAllActions()
            grandpa.moveToNextRoom(goingLeft: false, duration: duration)
            
            movingRightThroughHousePresentScene(runAction: wait)
        }else{
            movingRightThroughHousePresentScene(runAction: wait)
        }
    }
    
    func leftArrowTapped(moveWithDuration : Double){
        movedFromAnotherScene = true
        movedToSceneFromLeftArrowTouched = true
        
        audio.playButtonClickSound(scene: _scene, atVolume: defaultSoundVolume)
        
        _scene.childNode(withName: sceneChangeArrowRightName)?.removeFromParent()
        _scene.childNode(withName: sceneChangeArrowLeftName)?.removeFromParent()
        
        let duration : Double = moveWithDuration
        
        let wait = SKAction.wait(forDuration: duration)
        if let grandpa = _scene.childNode(withName: grandpaName) as? Grandpa{
            grandpa.removeAllActions()
            grandpa.moveToNextRoom(goingLeft: true, duration: duration)
            
            movingLeftThroughHousePresentScene(runAction: wait)
        }else{
            movingLeftThroughHousePresentScene(runAction: wait)
        }
    }
    
    private func movingLeftThroughHousePresentScene(runAction : SKAction){
        var sceneToGoTo : SKScene!
        
        _scene.run(runAction) {
            if self._scene.name == livingRoomName {
                sceneToGoTo = BedroomScene(size: UIScreen.main.bounds.size)
            }else if self._scene.name == bedroomName {
                print("No Where to go to")
            }else if self._scene.name == bathroomName {
                sceneToGoTo = LivingRoomScene(size: UIScreen.main.bounds.size)
                
            }
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: self._scene, fadeWithDuration: 0.5, audioPlayer: nil)
        }
    }
    
    private func movingRightThroughHousePresentScene(runAction : SKAction){
        var sceneToGoTo : SKScene!
        
        _scene.run(runAction) {
            if self._scene.name == livingRoomName {
                sceneToGoTo = BathroomScene(size: UIScreen.main.bounds.size)
            }else if self._scene.name == bedroomName {
                sceneToGoTo = LivingRoomScene(size: UIScreen.main.bounds.size)
            }else if self._scene.name == bathroomName {
                print("No Where to go to")
                
            }
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: self._scene, fadeWithDuration: 0.5, audioPlayer: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
