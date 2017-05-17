//
//  MenuButton.swift
//  My Grandpa
//
//  Created by Rick Crane on 01/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class MenuButton : SpriteCreator {
    
    private let firstSpriteStartPos : CGFloat = 40
    private let spaceBelowOtherSprites : CGFloat = 25
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    private let _downFromSprite : String?
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?, downFromSpriteNamed: String?) {

        _scene = scene
        _texture = texture
        _zPosition = 2
        _anchorPoint = anchorPoints
        _name = name
        _downFromSprite = downFromSpriteNamed
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name: _name, downFromSpriteNamed: _downFromSprite)
        self.xScale = 0.3
        self.yScale = self.xScale
        self.zPosition = 11
        self.name = name
        
        if _menuButtonsArray.count >= 4{
            _menuButtonsArray = []
        }
        
        if itIsDayTime == false {
            self.color = nightColor
            self.colorBlendFactor = nightBlendValue
        }
        
        if downFromSpriteNamed == nil {
            self.position = CGPoint(
                x: scene.frame.maxX + self.frame.size.width,
                y: scene.frame.midY + firstSpriteStartPos)
        }else{
            self.position = CGPoint(
                x: scene.frame.maxX + self.frame.size.width,
                y: ((scene.childNode(withName: downFromSpriteNamed!)?.frame.minY)! - spaceBelowOtherSprites))
        }
        _menuButtonsArray.append(self)
        moveButton()
    }
    
    private func moveButton(){
        let randomValue = randomBetweenNumbers(firstNum: 7, secondNum: 15)
        var pointToMoveTo = CGPoint()
        
        pointToMoveTo = CGPoint(x: (_scene.frame.maxX) - self.position.x / randomValue,
                                y: self.position.y)
        
        let action = SKAction.move(to: pointToMoveTo, duration: randomBetweenNumbersDouble(firstNum: 0.5, secondNum: 1))
        self.run(action)
    }
    
    func menuButtonClicked(buttonSelected : String){
        
        let buttonTouched = _scene.childNode(withName: buttonSelected)
        
        for button in _menuButtonsArray {
            if buttonTouched?.name != button.name {
                let moveToLocation = CGPoint(x: _scene.frame.maxX + button.frame.size.width, y: button.position.y)
                let moveAndHide = SKAction.move(to: moveToLocation, duration: 0.5)
                button.run(moveAndHide)
                button.isUserInteractionEnabled = true
                
            }else{
                let FinalLocationY = CGPoint(x: button.position.x, y: _scene.frame.midY)
                let FinalLocationX = CGPoint(x: _scene.frame.minX - button.frame.size.width, y: _scene.frame.midY)
                let moveUpAction = SKAction.move(to: FinalLocationY, duration: 0.3)
                let moveLeftAction = SKAction.move(to: FinalLocationX, duration: 0.3)
                
                let runSequence = SKAction.sequence([moveUpAction, moveLeftAction])
                button.run(runSequence) {
                    for button in _menuButtonsArray{
                        button.removeAllActions()
                        button.removeFromParent()
                    }
                }
                button.isUserInteractionEnabled = true
            }
        }
    }
    
    func removeAllButtonsFromScene(){
        
        var counter = 4
        for button in _menuButtonsArray{
            
            let FinalLocationY = CGPoint(x: button.position.x, y: (_scene.frame.midY))
            let FinalLocationX = CGPoint(x: (_scene.frame.maxX) + button.frame.size.width, y: (_scene.frame.midY))
            let moveUpAction = SKAction.move(to: FinalLocationY, duration: 0.3)
            let moveLeftAction = SKAction.move(to: FinalLocationX, duration: 0.3)
            
            let runSequence = SKAction.sequence([moveUpAction, moveLeftAction])
            button.run(runSequence, completion: {
                button.removeFromParent()
                counter = counter - 1
                
                if counter == 0 {
                    _menuButtonsArray = []
                }
                
            })
            button.isUserInteractionEnabled = true
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
