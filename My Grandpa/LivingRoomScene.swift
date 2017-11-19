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
    
    //NEED THIS TO REMOVE FROM APPDELEGATE
    var viewController: GameViewController!
    
    override func didMove(to view: SKView) {
        self.name = "Living Room"
        sceneWeAreON = self
        //self.scaleMode = .resizeFill
        makeLivingRoomLayout()
        createStatusBar()
    }
    
    func createStatusBar(){
        statsBar = GrandpaStatusBar(scene: self, name: "StasBar", texture: nil, withSize: CGSize(width: 100, height: 200))
        self.addChild(statsBar)
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

}
