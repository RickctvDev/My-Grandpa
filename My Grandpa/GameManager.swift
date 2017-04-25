//
//  MoveToScene.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

let debugMode = true
let gameFont = "IndieFlower"
let gameTitleName = "My Grandpa"



//Make of size: UIScreen.main.bounds.size
func prepareForNewScene(sceneToPresent : SKScene, currentScene : SKScene){
    
    currentScene.removeAllActions()
    currentScene.removeAllChildren()
    currentScene.removeFromParent()
    
    sceneToPresent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    let reveal = SKTransition.fade(withDuration: 1)
    currentScene.view?.presentScene(sceneToPresent, transition: reveal)
}

