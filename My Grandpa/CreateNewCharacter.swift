//
//  CreateNewCharacter.swift
//  My Grandpa
//
//  Created by Rick Crane on 17/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class CreateNewGrandpa {
    
    //MUST HAVE VARIABLES
    private var stageDescriptionLabel : SKLabelNode = SKLabelNode(fontNamed: gameFont)
    private let _scene : SKScene!
    private var rightArrow : Arrow!
    private var leftArrow : Arrow!
    private var upArrow1 : Arrow!
    private var upArrow2 : Arrow!
    private var downArrow1 : Arrow!
    private var downArrow2 : Arrow!
    private var confirmButton : SpriteCreator!
    
    //USEFUL VARIABLES
    private var onStageNumber : Int = 1
    private var raceLabel : SKLabelNode = SKLabelNode(fontNamed: gameFont) //This needs to be deleted once we have the images
    
    //FINDING SPRITES VARIABLES
    private let findGrandpaSprite : SKNode!
    private let findGroundSprite : SKNode!
    private let cam : Camera!
    
    init(onScene : SKScene){
        self._scene = onScene
        findGrandpaSprite = _scene.childNode(withName: grandpaName)
        findGroundSprite  = _scene.childNode(withName: groundName)
        cam = _scene.childNode(withName: cameraName) as! Camera
    }
    
    func startStage1(){
        //Make Timer for this to spawn
        let waitTimer = SKAction.wait(forDuration: 2)
        _scene.run(waitTimer){
            self.makeTEMPRaceLabel() // need to remove this at some point
            self.makeDescriptonLabel()
            self.makeArrows()
            self.makeConfirmButton()
        }
    }
    
    func startStage2(){
        //CREATE BIRTHDAY STAGE
        rightArrow.removeFromParent()
        leftArrow.removeFromParent()
        
        //MOVE CAMERA TO POS
        let pos = CGPoint(x: cam.position.x + 40, y: cam.position.y)
        cam.moveToPos(position: pos, withTime: 0.3, withZoom: nil)
        
        //MOVE CONFIRM BUTTON
        _scene.childNode(withName: "confirmButton")?.position = CGPoint(x: downArrow1.position.x + downArrow1.frame.size.width,
                                                                         y: downArrow1.position.y - downArrow1.frame.size.height)
        
        //CHANGE THE TUTORIAL LABEL
        stageDescriptionLabel.text = "Choose his Birthday"
        stageDescriptionLabel.fontSize = 10
        stageDescriptionLabel.position = CGPoint(x: upArrow1.position.x + upArrow1.frame.size.width,
                                          y: stageDescriptionLabel.position.y)
        
        //CREATE CALENDARS TO PICK DATE OF BIRTH
        dayCal = CalendarCreator(scene: onScene, texture: "calendar")
        dayCal.position = CGPoint(x: upArrow1.position.x, y: upArrow1.frame.minY - upArrow1.frame.size.height / 1.5)
        onScene.addChild(dayCal)
        dayCal.makeLabel(onScene: onScene, withText: "DD")
        
        monthCal = CalendarCreator(scene: onScene, texture: "calendar")
        monthCal.position = CGPoint(x: upArrow2.position.x, y: upArrow2.frame.minY - upArrow2.frame.size.height / 1.5)
        onScene.addChild(monthCal)
        monthCal.makeLabel(onScene: onScene, withText: "MM")
    }
    
    func confirmButtonPressed(){
        onStageNumber += 1
    }
    
    func resetStages(){
        onStageNumber = 1
    }
    
    private func makeConfirmButton(){
        confirmButton = SpriteCreator(scene: _scene, texture: "confirmButton", zPosition: 116, anchorPoints: nil, name: "confirmButton")
        confirmButton.size = rightArrow.size
        confirmButton.position = CGPoint(x: rightArrow.position.x, y: findGroundSprite.frame.maxY + 15)
        
        _scene.addChild(confirmButton)
    }
    
    private func makeArrows(){
        
        if onStageNumber == 1 {
            rightArrow = Arrow(scene: _scene, texture: "arrow", zPosition: 115, anchorPoints: nil, name: "rightArrow")
            leftArrow = Arrow(scene: _scene, texture: "arrowLeft", zPosition: 115, anchorPoints: nil, name: "leftArrow")
            
            rightArrow.position = CGPoint(x: findGrandpaSprite.frame.maxX + 30,
                                          y: findGrandpaSprite.frame.midY + 20)
            leftArrow.position = CGPoint(x: findGrandpaSprite.frame.minX - 30,
                                         y: rightArrow.position.y)
            
            _scene.addChild(rightArrow)
            _scene.addChild(leftArrow)
        }else if onStageNumber == 2{
            //MAKE NEW ARROWS
            upArrow1 = Arrow(scene: _scene, texture: "upArrow", zPosition: 115, anchorPoints: nil, name: "upArrow1")
            downArrow1 = Arrow(scene: _scene, texture: "downArrow", zPosition: 115, anchorPoints: nil, name: "downArrow1")
            upArrow2 = Arrow(scene: _scene, texture: "upArrow", zPosition: 115, anchorPoints: nil, name: "upArrow2")
            downArrow1 = Arrow(scene: _scene, texture: "downArrow", zPosition: 115, anchorPoints: nil, name: "downArrow2")
            
            //POSITION ARROWS
            upArrow1.position = CGPoint(x: findGrandpaSprite.frame.maxX + 30,
                                        y: findGrandpaSprite.frame.midY + upArrow1.frame.size.height * 2)
            upArrow2.position = CGPoint(x: upArrow1.position.x + upArrow2.frame.size.width * 2,
                                        y: upArrow1.position.y)
            
            downArrow1.position = CGPoint(x: upArrow1.position.x,
                                          y: findGrandpaSprite.frame.midY - 15)
            downArrow2.position = CGPoint(x: downArrow1.position.x + downArrow2.frame.size.width * 2,
                                          y: downArrow1.position.y)
            
            //ADD NEW ARROWS
            _scene.addChild(upArrow1)
            _scene.addChild(downArrow1)
            _scene.addChild(upArrow2)
            _scene.addChild(downArrow2)
        }
        
        
    }
    
    private func makeDescriptonLabel(){
        
        stageDescriptionLabel = SKLabelNode(fontNamed: gameFont)
        stageDescriptionLabel.fontSize = 15
        stageDescriptionLabel.zPosition = 20
        stageDescriptionLabel.text = "Choose Grandpas Race"
        
        stageDescriptionLabel.position = CGPoint(x: findGrandpaSprite.frame.midX,
                                                 y: findGrandpaSprite.frame.maxY + 25)
        
        if itIsDayTime == false{
            stageDescriptionLabel.fontColor = SKColor.white
        }
        
        _scene.addChild(stageDescriptionLabel)
    }
    
    private func makeTEMPRaceLabel(){
        self.raceLabel.name = raceNameLabelThatWillBeRemovedWithImagesLater
        self.raceLabel.fontColor = SKColor.black
        self.raceLabel.fontSize = 15
        self.raceLabel.zPosition = 20
        
        self.raceLabel.text = grandpaRaces[0]
        
        self.raceLabel.position = CGPoint(x: findGrandpaSprite.frame.midX,
                                          y: findGrandpaSprite.frame.maxY + 10)
        
        _scene.addChild(self.raceLabel)
    }
}
