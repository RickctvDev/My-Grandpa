//
//  BedroomScene.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/09/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import GameplayKit
import AVFoundation

class BedroomScene: SKScene {
    
    private let bedroomScene = Bedroom()
    private var statsBar : GrandpaStatusBar!
    private var scenceChangeArrows : SceneChanger!
    private var grandpa         : Grandpa!
    
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
        self.name = bedroomName
        sceneWeAreON = self
        makeBedroomLayout()
        createStatusBar()
        createSceneChangeArrows()
    }
    
    func createGrandpa(){
        grandpa = Grandpa(scene: self, texture: grandpaName, zPosition: 8, anchorPoints: nil , name: grandpaName)
        grandpa.isHidden = true
        self.addChild(grandpa)
        
        let finalPos = CGPoint(x: self.frame.minX + grandpa.frame.size.width, y: self.frame.minY + 3)
        
        if movedFromAnotherScene == false{
            //MAKE YAWN HERE
            grandpa.isHidden = false
        }else{
            
            if movedToSceneFromLeftArrowTouched == false{
                grandpa.isHidden = false
                let firstPosition = CGPoint(x: self.frame.minX - grandpa.frame.size.width, y: self.frame.minY + 3)
                
                grandpa.position = firstPosition
                grandpa.moveToPoint(pos:finalPos , duration: 3)
                
            }else{
                grandpa.isHidden = false
                let firstPosition = CGPoint(x: self.frame.maxX + grandpa.frame.size.width, y: self.frame.minY + 3)
                
                grandpa.position = firstPosition
                grandpa.moveToPoint(pos:finalPos , duration: 3)
                
            }
            movedToSceneFromLeftArrowTouched = false
            movedFromAnotherScene = false
        }
    }
    
    func makeBedroomLayout(){
        bedroomScene.createRoom(onScene: scene!)
    }
    
    func createStatusBar(){
        statsBar = GrandpaStatusBar(scene: self, name: "StasBar", texture: nil, withSize: CGSize(width: 100, height: 200))
        self.addChild(statsBar)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if shouldResetNow == true {
            shouldResetNow  = false
            let sceneToGoTo = LoadingScreen(size: UIScreen.main.bounds.size)
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: self, fadeWithDuration: 0.5, audioPlayer: nil) //NEED TO MAKE AUDIO
        }
    }
    
    func createSceneChangeArrows(){
        scenceChangeArrows = SceneChanger(scene: self, texture: "predefinedInClass", zPosition: 3000, anchorPoints: nil, name: "predefinedInClass")
        self.addChild(scenceChangeArrows)
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
            }
        }
    }
    
}


