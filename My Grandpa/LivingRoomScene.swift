//
//  LivingRoomScene.swift
//  My Grandpa
//
//  Created by Rick Crane on 26/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import GameplayKit
import AVFoundation

class LivingRoomScene: SKScene {
    
    private let livingRoomClass = LivingRoom()
    
    override func didMove(to view: SKView) {
        self.name = "Living Room"
        //self.scaleMode = .resizeFill
        makeLivingRoomLayout()
    }
    
    func makeLivingRoomLayout(){
        livingRoomClass.createLivingRoom(onScene: self)
    }

}
