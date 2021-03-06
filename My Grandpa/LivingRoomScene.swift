//
//  LivingRoomScene.swift
//  My Grandpa
//
//  Created by Rick Crane on 26/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.

//NEED TO START WORKING ON THE MAIN ROOM AND THE FUNCTIONALITY
//

import GameplayKit
import AVFoundation

class LivingRoomScene: SKScene {
    
    private let livingRoomClass = LivingRoom()
    private var statsBar : GrandpaStatusBar!
    private var scenceChangeArrows : SceneChanger!
    private var grandpa         : Grandpa!
    private var settingsMenu : SettingsMenu!
    
    //NEED THIS TO REMOVE FROM APPDELEGATE
    var viewController: GameViewController!
    
    override func didMove(to view: SKView) {
        initalSetup()
        createGrandpa()
        waitAndEnableControls()
    }
    
    private func waitAndEnableControls(){
        scenceChangeArrows.enableTouchEventsOnArrowControls()
    }
    
    private func initalSetup(){
        self.name = livingRoomName
        sceneWeAreON = self
        _ = WifiConnectionChecker(onScene: self)
        //self.scaleMode = .resizeFill
        makeLivingRoomLayout()
        createStatusBar()
        createSceneChangeArrows()
        settingsMenuSetup()
    }
    
    private func settingsMenuSetup(){
        settingsMenu = SettingsMenu(scene: self, texture: settingsMenuIconName, zPosition: 50004, anchorPoints: nil, name: settingsMenuIconName)
        self.addChild(settingsMenu)
    }
    
    func createGrandpa(){
        grandpa = Grandpa(scene: self, texture: grandpaName, zPosition: 8, anchorPoints: nil , name: grandpaName)
        grandpa.isHidden = true
        self.addChild(grandpa)
        
        let finalPos = CGPoint(x: self.frame.midX + grandpa.frame.size.width, y: self.frame.minY + 3)
        
        if movedFromAnotherScene == false{
            grandpa.isHidden = false
        }else{
            
            if movedToSceneFromLeftArrowTouched == false{
                grandpa.isHidden = false
                let firstPosition = CGPoint(x: self.frame.minX - grandpa.frame.size.width, y: self.frame.minY + 3)
                
                grandpa.position = firstPosition
                grandpa.moveToPoint(pos:finalPos , duration: 1.5)
                
            }else{
                grandpa.isHidden = false
                let firstPosition = CGPoint(x: self.frame.maxX + grandpa.frame.size.width, y: self.frame.minY + 3)
                
                grandpa.position = firstPosition
                grandpa.moveToPoint(pos:finalPos , duration: 1.5)
                
            }
            movedToSceneFromLeftArrowTouched = false
            movedFromAnotherScene = false
        }
    }
    
    func createStatusBar(){
        statsBar = GrandpaStatusBar(scene: self, name: "StasBar", texture: nil, withSize: CGSize(width: 100, height: 200))
        self.addChild(statsBar)
    }
    
    func createSceneChangeArrows(){
        scenceChangeArrows = SceneChanger(scene: self, texture: "predefinedInClass", zPosition: 3000, anchorPoints: nil, name: "predefinedInClass")
        self.addChild(scenceChangeArrows)
    }
    
    func makeLivingRoomLayout(){
        livingRoomClass.createLivingRoom(onScene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if shouldResetNow == true {
            shouldResetNow  = false
            let sceneToGoTo = LoadingScreen(size: UIScreen.main.bounds.size)
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: self, fadeWithDuration: 0.5, audioPlayer: nil) //NEED TO MAKE AUDIO
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == sceneChangeArrowRightName{
                scenceChangeArrows.rightArrowTapped(moveWithDuration: 1.5)
                
            }else if node.name == sceneChangeArrowLeftName{
               scenceChangeArrows.leftArrowTapped(moveWithDuration: 1.5)
            }else if node.name == grandpa.name {
                grandpa.playPainVoice()
            }else if node.name == settingsMenuIconName {
                settingsMenu.tappedForOpen()
            }else if node.name == closeButtonName {
                settingsMenu.closeMenu()
            }else if node.name == musicButtonName {
                settingsMenu.turnOnOffMainMusic()
            }else if node.name == soundButtonName {
                settingsMenu.turnOnOffButtonSounds()
            }else if node.name == notificationButtonName {
                settingsMenu.turnOnOffNotifications()
            }
        }
    }

}
