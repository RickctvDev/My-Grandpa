//
//  Billboard.swift
//  My Grandpa
//
//  Created by Rick Crane on 11/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class Billboard : SpriteCreator {
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoints : CGPoint?
    private let _name : String?
    
    private var soundButton : SKSpriteNode!
    private var musicButton : SKSpriteNode!
    private var notificationButton : SKSpriteNode!
    private let timerInterval : Double = 0.5
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        _scene = scene
        _texture = texture
        _zPosition = zPosition
        _anchorPoints = anchorPoints
        _name = name
        
        super.init(scene: scene, texture: texture, zPosition: zPosition, anchorPoints: anchorPoints, name: name)
        
        self.xScale = 0.6
        self.yScale = self.xScale
        
        self.position.x = scene.frame.maxX + (self.frame.size.width - 70)
        self.position.y = scene.frame.midY
        
        createCloseButton()

    }
    
    func showBillBoard(nodeName: String, onScene: SKScene){
        //this will be the function to choose which one to show
        if nodeName == settingsButtonName {
            makeSettingsBillBoard(scene: onScene)
            
        }else if nodeName == shopButtonName{
            makeShopBillBoard(scene: onScene)
            
        }else if nodeName == statsButtonName{
            makeStatsBillBoard(scene: onScene)
            
        }else if nodeName == creditsButtonName{
            makeCreditsBillBoard(scene: onScene)
            
        }else{
            print("Could not find this billboard setting -> Check billboard class")
        }
        moveMenuBillBoard(scene: onScene)
    }
    
    private func makeSettingsBillBoard(scene : SKScene){
        print("Made -> SETTINGS")
        
        if soundIsOn {
            self.musicButton = SKSpriteNode(imageNamed: "soundOn")
        }else {
            self.musicButton = SKSpriteNode(imageNamed: "SoundOffButton")
        }
        
        if otherSoundIsOn {
            self.soundButton = SKSpriteNode(imageNamed: "soundOn")
        }else{
            self.soundButton = SKSpriteNode(imageNamed: "SoundOffButton")
        }
        
        let musicTitle = SKLabelNode(text: "Music")
        musicTitle.fontSize = 40
        musicTitle.zPosition = 7
        musicTitle.fontColor = UIColor.black
        musicTitle.position.y = 40
        musicTitle.position.x = -200
        self.addChild(musicTitle)
        
        musicButton.name = musicButtonName
        musicButton.zPosition = 7
        musicButton.xScale = 0.1
        musicButton.position.x = musicTitle.position.x + 100
        musicButton.position.y = musicTitle.position.y + 15
        musicButton.yScale = musicButton.xScale
        self.addChild(musicButton)
        
        let soundTitle = SKLabelNode(text: "Sound")
        soundTitle.fontSize = 40
        soundTitle.zPosition = 7
        soundTitle.fontColor = UIColor.black
        soundTitle.position.y = musicTitle.position.y - 70
        soundTitle.position.x = -200
        self.addChild(soundTitle)
        
        soundButton.name = soundButtonName
        soundButton.zPosition = 7
        soundButton.xScale = 0.1
        soundButton.position.x = soundTitle.position.x + 100
        soundButton.position.y = soundTitle.position.y + 15
        soundButton.yScale = soundButton.xScale
        self.addChild(soundButton)
        
        let notificationTitle = SKLabelNode(text: "Notifications")
        notificationTitle.fontSize = 40
        notificationTitle.zPosition = 7
        notificationTitle.fontColor = UIColor.black
        notificationTitle.position.y = soundTitle.position.y - 70
        notificationTitle.position.x = soundTitle.position.x + 40
        self.addChild(notificationTitle)
        
        if notificationsSwitchedOn {
            notificationButton = SKSpriteNode(imageNamed: "notsOn")
        }else{
            notificationButton = SKSpriteNode(imageNamed: "notsOff")
        }
        
        notificationButton.name = notificationButtonName
        notificationButton.zPosition = 7
        notificationButton.size = CGSize(width: 150, height: 75)
        notificationButton.position.x = notificationTitle.position.x + 180
        notificationButton.position.y = notificationTitle.position.y + 15
        self.addChild(notificationButton)
    }
    
    private func makeShopBillBoard(scene : SKScene){
        print("Made -> SHOP")
    }
    
    private func makeStatsBillBoard(scene : SKScene){
        print("Made -> STATS")
    }
    
    private func makeCreditsBillBoard(scene : SKScene){
        print("Made -> CREDITS")
        let credits = CreditsPage()
        credits.runCredits(onNode: self)
    }
    
    private func moveMenuBillBoard(scene : SKScene){
        let billBoardFinalPos = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        self.run(SKAction.move(to: billBoardFinalPos, duration: 0.7)) {
            let wait = SKAction.wait(forDuration: self.timerInterval)
            self.run(wait, completion: {
                
            })
        }
    }
    
    func turnOnOffMainMusic(){
        if soundIsOn == true{
            soundIsOn = false
            musicButton.texture = SKTexture(imageNamed: "SoundOffButton")
            print("MAIN SOUND IS OFF")
        }else{
            soundIsOn = true
            musicButton.texture = SKTexture(imageNamed: "soundOn")
            
            print("MAIN SOUND IS ON")
        }
    }
    
    func turnOnOffButtonSounds(){
        if otherSoundIsOn == true{
            otherSoundIsOn = false
            soundButton.texture = SKTexture(imageNamed: "SoundOffButton")
            print("OTHER SOUND IS OFF")
        }else{
            otherSoundIsOn = true
            soundButton.texture = SKTexture(imageNamed: "soundOn")
            print("OTHER SOUND IS ON")
        }
    }
    
    func turnOnOffNotifications(){
        if notificationsSwitchedOn == true{
            notificationsSwitchedOn = false
            notificationButton.texture = SKTexture(imageNamed: "notsOff")
            print("NOTS ARE OFF")
        }else{
            notificationsSwitchedOn = true
            notificationButton.texture = SKTexture(imageNamed: "notsOn")
            print("NOTS ARE ON")
        }
    }
    
    func removeBillBoard(){
        let moveBillBoardOffScreen = SKAction.moveTo(x: (scene?.frame.minX)! - self.frame.size.width, duration: timerInterval)
        self.run(moveBillBoardOffScreen) {
            self.removeFromParent()
        }
    }
    
    private func createCloseButton(){
        let closeButton = SKSpriteNode(imageNamed: closeButtonName)
        closeButton.zPosition = 15
        closeButton.name = closeButtonName
        closeButton.xScale = 0.2
        closeButton.yScale = closeButton.xScale
        closeButton.position = CGPoint(x: 250, y: 125)
        self.addChild(closeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
