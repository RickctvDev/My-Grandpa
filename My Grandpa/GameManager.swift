//
//  MoveToScene.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

//DEV CONFIG
let debugMode = true
let gameFont = "IndieFlower"
let gameTitleName = "My Grandpa"
var userConnectedWithLoginCredentials = false

//GAME SETTINGS
let timeSunRise = 7
let timeSunSet = 20
let grandpaSleepTime = 22
let nightColor = SKColor.black
let nightBlendValue : CGFloat = 0.15
let nightTimeColorBG = UIColor(red: 25 / 255, green: 74 / 255, blue: 109 / 255, alpha: 1)
let dayTimeColorBG = UIColor(red: 51 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)

//USEFUL FUNCTIONS
//Make of size: UIScreen.main.bounds.size
func prepareForNewScene(sceneToPresent : SKScene, currentScene : SKScene){
    
    currentScene.removeAllActions()
    currentScene.removeAllChildren()
    currentScene.removeFromParent()
    
    sceneToPresent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    let reveal = SKTransition.fade(withDuration: 1)
    currentScene.view?.presentScene(sceneToPresent, transition: reveal)
}

