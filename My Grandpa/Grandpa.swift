//
//  Grandpa.swift
//  My Grandpa
//
//  Created by Rick Crane on 10/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Grandpa : SpriteCreator{
    
    private let _scene : SKScene!
    private var _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint = CGPoint(x: 0.5, y: 0)
    private var _name : String?
    private let usersData = UsersData()
    private var userCompletedTut = false
    private var chosenName = String()
    private var chosenRace = String()
    private var mainScreenScale : CGFloat = 0.03
    private var insideHouseScale : CGFloat = 0.14
    
    var nameChosenByUser : String{
        get{
            return chosenName
        }
    }
    
    var raceChosenByUser : String{
        get {
            return chosenRace
        }
    }
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        
        _scene = scene
        _texture = texture
        _zPosition = zPosition
        _name = grandpaName
        
        super.init(scene: scene, texture: texture, zPosition: zPosition, anchorPoints: _anchorPoint, name: name)
        
        chosenName = usersData.getDataFromKey(Key: nameChosen) as! String
        chosenRace = usersData.getDataFromKey(Key: racePicked) as! String
        
        self.xScale = 0.1
        self.yScale = self.xScale
        
        //If on main menu
        if scene.name == mainMenuName{
        
            //check to see if they have saved data
            if userHasSavedGameFile == true{
                //should load his grandpa here that user has created
                //This is not correct right now, we need to GRAB THE ACTUAL GRANDPA SELECTED WHEN THIS HAPPENS
                _texture = usersData.getDataFromKey(Key: racePicked) as! String
                _name = usersData.getDataFromKey(Key: nameChosen) as? String
                
                
                //check if grandpa is sleeping
                if grandpaIsSleeping == false {
                    //position him outside the house
                    grandpaNextToHouse(scene: scene)
                }else{
                    //grandpa should be hidden to sleep
                    grandpaIsInTheHouse(scene: scene)
                }
            }else{
                //user does not have saved game file - hide him
                grandpaIsInTheHouse(scene: scene)
            }
        }else if scene.name != mainMenuName {
            //THEN LOAD UP SOME OTHER DATA
            self.xScale = insideHouseScale
            self.yScale = insideHouseScale
            
            if grandpaIsSleeping == true{
                self.position = CGPoint(x: _scene.frame.minX + self.frame.size.width, y: _scene.frame.minY + 3)
            }else{
                self.position = CGPoint(x: _scene.frame.midX + self.frame.size.width,
                                        y: _scene.frame.minY + 3)
            }
        }
    }
    
    private func makeNameLabelAppear(){
        
        if userHasSavedGameFile != false {
            let nameLabel = SKLabelNode(fontNamed: gameFont)
            nameLabel.text = nameChosenByUser
            nameLabel.fontSize = 15
            nameLabel.zPosition = 5000
            nameLabel.fontColor = UIColor.black
            nameLabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + 15)
            _scene.addChild(nameLabel)
            
            let fadeOutLabel = SKAction.fadeOut(withDuration: 1.2)
            nameLabel.run(fadeOutLabel) {
                nameLabel.removeFromParent()
            }
        }
    }
    
    private func grandpaNextToHouse(scene: SKScene){
        let house = scene.childNode(withName: houseName)
        let ground = scene.childNode(withName: groundName)
        
        self.position = CGPoint(x: (house?.frame.maxX)! + self.frame.size.width / 2,
                                y: (ground?.frame.maxY)! - 30)
    }
    
    private func grandpaIsInTheHouse(scene : SKScene){
        let house = scene.childNode(withName: houseName)
        let ground = scene.childNode(withName: groundName)
        
        self.xScale = 0.03
        self.yScale = self.xScale
        self.zPosition = 3
        self.position = CGPoint(x: (house?.frame.midX)! - 5,
                                     y: (ground?.frame.maxY)! - self.frame.size.height / 4)
    }
    
    func playAngryVoice(){
        let voiceArray = ["angry1", "angry2", "angry3"]
        let random = Int(arc4random_uniform(UInt32(voiceArray.count)))
        let finalVoice = voiceArray[random]
        
        let playSound = SKAction.playSoundFileNamed(fileName: finalVoice, atVolume: defaultSoundVolume, waitForCompletion: true)
        self.run(playSound)
        
        makeGranpaShake()
        
    }
    
    func playPainVoice(){
        let voiceArray = ["pain1", "pain2", "pain3", "pain4"]
        let random = Int(arc4random_uniform(UInt32(voiceArray.count)))
        let finalVoice = voiceArray[random]
        
        let playSound = SKAction.playSoundFileNamed(fileName: finalVoice, atVolume: defaultSoundVolume, waitForCompletion: true)
        self.run(playSound)
        
        makeGranpaShake()
    }
    
    func userCompletedTutorial(){
        userCompletedTut = true
        let foundHouse = _scene.childNode(withName: houseName) as! House
        foundHouse.openAndCloseHouse(waitForDuration: 1.6)
        continueButtonPressed()
        
        let toPos = CGPoint(x: _scene.frame.midX, y: _scene.frame.midY)
        let cameraFound = _scene.childNode(withName: cameraName) as! Camera
        cameraFound.moveToPos(position: toPos, withTime: 0.7, withZoom: 1)
        
        let wait = SKAction.wait(forDuration: 2.5)
        self.run(wait, completion: {
            let sceneToPresent = LivingRoomScene(size: UIScreen.main.bounds.size)
            
            prepareForNewScene(sceneToPresent: sceneToPresent, currentScene: self._scene, fadeWithDuration: 2.5, audioPlayer: nil)
        })
    }
    
    func createButtonPressed(toPos : CGPoint, timeToMove : Double){
        
        let rotateByAngleLeft = SKAction.rotate(byAngle: 0.09, duration: 0.15)
        let holdRotation = SKAction.wait(forDuration: 1)
        let wait = SKAction.wait(forDuration: 0.6)
        let roateActionRight = rotateByAngleLeft.reversed()
        
        self.run(wait){
            self.zPosition = 8
            let seq = SKAction.sequence([rotateByAngleLeft, holdRotation, roateActionRight])
            self.run(seq)
            
            let moveToPos = SKAction.move(to: toPos, duration: timeToMove)
            self.run(moveToPos)
            
            let endScale = SKAction.scale(to: 0.1, duration: timeToMove)
            self.run(endScale)
        }
    }
    
    func continueButtonPressed(){
        
        if grandpaIsSleeping == true && userCompletedTut == false{
            
            self.isHidden = true
            scene?.run(SKAction.fadeOut(withDuration: 0.5))
            
        }else {
            let timer : Double = 2
            
            makeMoveAnimation()
            
            let finalPos = CGPoint(x: _scene.frame.minX + self.frame.size.width / 1.5, y: _scene.frame.minY + self.frame.height / 3.5)
            let finalScale = SKAction.scale(to: 0.05, duration: timer)
            let charcterMoveToPos = SKAction.move(to: finalPos, duration: timer)
            let moveLeftOffScreen = SKAction.moveBy(x: -50, y: 0, duration: 0.5)
            
            self.run(charcterMoveToPos, completion: {
                self.zPosition = 3
                
                let wait = SKAction.wait(forDuration: 0.5)
                self.run(wait)
                self.run(moveLeftOffScreen)
                self.run(wait, completion: {
                    self.removeFromParent()
                })
            })
            self.run(finalScale)
        }
    }
    
    func moveToPoint(pos : CGPoint, duration : Double){
        makeMoveAnimation()
        let moveto = SKAction.move(to: pos, duration: duration)
        self.run(moveto) {
            self.removeAnimations()
        }
    }
    
    func moveToNextRoom(goingLeft : Bool, duration: Double){
        makeMoveAnimation()
        var moveto : CGPoint
        var moveAction : SKAction
        
        
        if goingLeft == true {
            moveto = CGPoint(x: _scene.frame.minX - self.frame.size.width, y: _scene.frame.minY)
        }else{
             moveto = CGPoint(x: _scene.frame.maxX + self.frame.size.width, y: _scene.frame.minY)
        }
        moveAction = SKAction.move(to: moveto, duration: duration)
        self.run(moveAction)
    }
    
    private func makeMoveAnimation(){
        let rotateActionLeft = SKAction.rotate(byAngle: 0.05, duration: 0.15)
        let roateActionRight = rotateActionLeft.reversed()
        let rotateActionComplete = SKAction.sequence([rotateActionLeft,roateActionRight, roateActionRight, rotateActionLeft])
        let runActionForever = SKAction.repeatForever(rotateActionComplete)
        self.run(runActionForever)
    }
    
    private func removeAnimations(){
        self.removeAllActions()
    }
    
    private func makeGranpaShake(){
        makeNameLabelAppear()
        let grandadGoLeft = SKAction.moveBy(x: -2, y: 0, duration: 0.03)
        let grandadGoRight = SKAction.moveBy(x: 2, y: 0, duration: 0.03)
        let seq = SKAction.sequence([grandadGoLeft, grandadGoRight, grandadGoRight, grandadGoLeft])
        self.run(seq)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
