//
//  Settings Menu.swift
//  My Grandpa
//
//  Created by Rick Crane on 26/11/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class SettingsMenu: SpriteCreator {
    
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    private let sizeOfButton : CGFloat = 0.3
    private let audioMaker = AudioMaker()
    private let nodes_Z_Position : CGFloat = 99999
    private var backgroundFadeColor = SKSpriteNode()
    private var settingsMenuBoard = SKSpriteNode()
    private var soundButton = SKSpriteNode()
    private var musicButton = SKSpriteNode()
    private var notificationButton = SKSpriteNode()
    private let usersData = UsersData()
    
    override init(scene: SKScene, texture: String, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        
        _scene = scene
        _texture = texture
        _zPosition = 5010
        _anchorPoint = anchorPoints
        _name = settingsMenuIconName
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name : _name)
        
        self.xScale = sizeOfButton
        self.yScale = self.xScale
        self.position = CGPoint(x: scene.frame.maxX - self.frame.size.width,
                                y: scene.frame.maxY - self.frame.size.height)
        
    }
    
    func tappedForOpen(){
        audioMaker.playButtonClickSound(scene: scene!, atVolume: defaultSoundVolume)
        usersData.grabUsersCurrentSettingsData()
        makeBackgroundFadeOverlay()
        makeSettingsBoard()
        createCloseButton(onBoard: settingsMenuBoard)
        makeTabsForSettingsMenu(onBoard: settingsMenuBoard)
    }
    
    func closeMenu(){
        audioMaker.playButtonClickSound(scene: _scene, atVolume: defaultSoundVolume)
        backgroundFadeColor.removeFromParent()
        settingsMenuBoard.removeFromParent()
    }
    
    private func makeTabsForSettingsMenu(onBoard: SKSpriteNode){
        let navBar = SKSpriteNode(color: UIColor.black, size: CGSize(width: onBoard.frame.size.width,
                                                                     height: onBoard.frame.size.height / 4.5))
        //navBar.anchorPoint = CGPoint(x: 0, y: 1)
        navBar.zPosition = nodes_Z_Position + 2
        navBar.position.y = onBoard.frame.maxY
        onBoard.addChild(navBar)
        
        
        let settingsTab = SKSpriteNode(color: .blue, size: CGSize(width: navBar.frame.size.width / 4,
                                                                  height: navBar.frame.size.height))
        settingsTab.position.x = navBar.frame.minX + settingsTab.frame.size.width / 2
        settingsTab.zPosition = navBar.zPosition + 1
        navBar.addChild(settingsTab)
        
        let settingsLabel = SKLabelNode(fontNamed: gameFont)
        settingsLabel.text = "SETTINGS"
        settingsLabel.fontSize = 22
        settingsLabel.fontColor = UIColor.black
        settingsTab.addChild(settingsLabel)
        
        let helpTab = SKSpriteNode(color: .gray, size: settingsTab.size)
        helpTab.position.x = settingsTab.frame.maxX + helpTab.frame.size.width / 2
        helpTab.zPosition = navBar.zPosition + 1
        navBar.addChild(helpTab)
        
        let helpBarLabel = SKLabelNode(fontNamed: gameFont)
        helpBarLabel.text = "HELP"
        helpBarLabel.fontSize = 22
        helpBarLabel.fontColor = UIColor.black
        helpTab.addChild(helpBarLabel)
        
        let socialTab = SKSpriteNode(color: .green, size: settingsTab.size)
        socialTab.position.x = helpTab.frame.maxX + socialTab.frame.size.width / 2
        socialTab.zPosition = navBar.zPosition + 1
        navBar.addChild(socialTab)
        
        let socialBarLabel = SKLabelNode(fontNamed: gameFont)
        socialBarLabel.text = "SOCIAL"
        socialBarLabel.fontSize = 22
        socialBarLabel.fontColor = UIColor.black
        socialTab.addChild(socialBarLabel)
    }
    
    private func makeSettingsBoard(){
        settingsMenuBoard = SKSpriteNode(color: UIColor.brown, size: CGSize(width: (scene?.frame.size.width)! / 1.4,
                                                                            height: (scene?.frame.size.height)! / 1.5))
        settingsMenuBoard.zPosition = nodes_Z_Position + 1
        _scene.addChild(settingsMenuBoard)
        createSettingsMenuInfo()
    }
    
    private func createSettingsMenuInfo(){
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
        musicTitle.zPosition = nodes_Z_Position + 11
        musicTitle.fontColor = UIColor.black
        musicTitle.position.y = 40
        musicTitle.position.x = -200
        settingsMenuBoard.addChild(musicTitle)
        
        musicButton.name = musicButtonName
        musicButton.zPosition = nodes_Z_Position + 10
        musicButton.xScale = 0.1
        musicButton.position.x = musicTitle.position.x + 100
        musicButton.position.y = musicTitle.position.y + 15
        musicButton.yScale = musicButton.xScale
        settingsMenuBoard.addChild(musicButton)
        
        let soundTitle = SKLabelNode(text: "Sound")
        soundTitle.fontSize = 40
        soundTitle.zPosition = nodes_Z_Position + 11
        soundTitle.fontColor = UIColor.black
        soundTitle.position.y = musicTitle.position.y - 70
        soundTitle.position.x = -200
        settingsMenuBoard.addChild(soundTitle)
        
        soundButton.name = soundButtonName
        soundButton.zPosition = nodes_Z_Position + 10
        soundButton.xScale = 0.1
        soundButton.position.x = soundTitle.position.x + 100
        soundButton.position.y = soundTitle.position.y + 15
        soundButton.yScale = soundButton.xScale
        settingsMenuBoard.addChild(soundButton)
        
        let notificationTitle = SKLabelNode(text: "Notifications")
        notificationTitle.fontSize = 40
        notificationTitle.zPosition = nodes_Z_Position + 11
        notificationTitle.fontColor = UIColor.black
        notificationTitle.position.y = soundTitle.position.y - 70
        notificationTitle.position.x = soundTitle.position.x + 40
        settingsMenuBoard.addChild(notificationTitle)
        
        if notificationsSwitchedOn {
            notificationButton = SKSpriteNode(imageNamed: "notsOn")
        }else{
            notificationButton = SKSpriteNode(imageNamed: "notsOff")
        }
        
        notificationButton.name = notificationButtonName
        notificationButton.zPosition = nodes_Z_Position + 10
        notificationButton.size = CGSize(width: 150, height: 75)
        notificationButton.position.x = notificationTitle.position.x + 180
        notificationButton.position.y = notificationTitle.position.y + 15
        settingsMenuBoard.addChild(notificationButton)
    }
    
    private func makeBackgroundFadeOverlay(){
        backgroundFadeColor = SKSpriteNode(color: UIColor.black, size: CGSize(width: _scene.frame.size.width, height: _scene.frame.size.height))
        backgroundFadeColor.alpha = 0.65
        backgroundFadeColor.zPosition = nodes_Z_Position
        _scene.addChild(backgroundFadeColor)
    }
    
    private func createCloseButton(onBoard : SKSpriteNode){
        let closeButton = SKSpriteNode(imageNamed: closeButtonName)
        closeButton.name = closeButtonName
        closeButton.zPosition = nodes_Z_Position + 3
        closeButton.name = closeButtonName
        closeButton.xScale = 0.2
        closeButton.yScale = closeButton.xScale
        closeButton.anchorPoint = CGPoint(x: 1, y: 1)
        closeButton.position = CGPoint(x: onBoard.frame.maxX,
                                       y: onBoard.frame.maxY + closeButton.frame.size.height / 2)
        onBoard.addChild(closeButton)
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
        
        usersData.saveData(KeyName: user_Set_Music_Value, dataToPass: soundIsOn)
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
        
        usersData.saveData(KeyName: user_Set_Sound_Value, dataToPass: otherSoundIsOn)
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
        
        usersData.saveData(KeyName: user_Set_Notifications_Value, dataToPass: notificationsSwitchedOn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
