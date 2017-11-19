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
    
    private let bathroomScene = Bedroom()
    private var statsBar : GrandpaStatusBar!
    
    //NEED THIS TO REMOVE FROM APPDELEGATE
    var viewController: GameViewController!
    
    override func didMove(to view: SKView) {
        self.name = "Bedroom"
        sceneWeAreON = self
        
        makeBathRoomLayout()
        createStatusBar()
    }
    
    func makeBathRoomLayout(){
        bathroomScene.createRoom(onScene: scene!)
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
    
}


