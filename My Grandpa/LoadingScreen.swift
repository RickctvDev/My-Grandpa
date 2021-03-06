//
//  GameScene.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import GameplayKit
import AVFoundation

class LoadingScreen: SKScene {
    
    private var connectionTimeOut = false
    private var loadingText : SKLabelNode! = nil
    private var warning : SpriteCreator! = nil
    
    //NEED THIS TO REMOVE FROM APPDELEGATE
    var viewController: GameViewController!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 51 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
        makeLoadingScreen()
        loadingAnimation()
        checkForInternetConnection()
        
    }
    
    private func makeLoadingScreen(){
        let fence = SpriteCreator(scene: self, texture: fenceName, zPosition: 8, anchorPoints: CGPoint(x: 0.5, y: 0), name: nil)
        fence.size = CGSize(width: self.frame.size.width, height: 200)
        fence.position.x = self.frame.midX
        fence.position.y = self.frame.minY - fence.frame.size.height / 3
        self.addChild(fence)
        
        
        let face = SpriteCreator(scene: self, texture: grandpaName, zPosition: 5, anchorPoints: CGPoint(x: 0.5, y: 0.5), name: nil)
        face.xScale = 0.7
        face.yScale = face.xScale
        face.position = CGPoint(x: self.frame.midX, y: fence.frame.maxY - face.frame.size.height / 4)
        self.addChild(face)
        
        let logo = SKLabelNode(text: gameTitleName)
        logo.fontColor = SKColor.black
        logo.fontSize = 50
        logo.zPosition = 6
        logo.fontName = gameFont
        logo.position.y = self.frame.maxY - logo.frame.size.height
        logo.position.x = self.frame.midX
        self.addChild(logo)
        
        loadingText = SKLabelNode(fontNamed: gameFont)
        loadingText.text = ""
        self.addChild(loadingText)
        
    }
    
    private func loadingAnimation(){
        loadingText.fontColor = SKColor.black
        loadingText.fontSize = 40
        loadingText.zPosition = 10
        loadingText.position.y = self.frame.minY + loadingText.frame.size.height + 20
        loadingText.position.x = self.frame.midX
        
        var count = 0
        let textArray = ["loading.", "loading..", "loading..."]
        _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (timer) in
            if self.connectionTimeOut == true {
                self.loadingText.alpha = 0
            }else{
                if count >= 3 {
                    count = 0
                    self.loadingText.alpha = 1
                }
                self.loadingText.text = textArray[count]
                count += 1
            }
        }
    }
    
    func makeConnectionBillBoard(){
        warning = SpriteCreator(scene: self, texture: billboardName, zPosition: 10, anchorPoints: nil, name : nil)
        warning.xScale = 0.8
        warning.yScale = warning.xScale
        
        let retryButton = SpriteCreator(scene: self, texture: retryButtonName, zPosition: 11, anchorPoints: nil, name: nil)
        retryButton.xScale = 0.3
        retryButton.yScale = retryButton.xScale
        retryButton.position = CGPoint(x: retryButton.position.x, y: warning.frame.minY + retryButton.frame.size.height / 2)
        warning.addChild(retryButton)
        
        let message = SKLabelNode(text: "Please check your internet connection")
        message.zPosition = 11
        message.fontColor = SKColor.black
        message.fontSize = 30
        message.zPosition = 10
        warning.addChild(message)
        
        self.addChild(warning)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == retryButtonName{
                warning.removeFromParent()
                connectionTimeOut = false
                checkForInternetConnection()
            }
        }
    }
    
    func checkForInternetConnection(){
        
        if debugMode == false {
            let waitForSec = SKAction.wait(forDuration: 3)
            self.run(waitForSec) {
                if self.currentReachabilityStatus != .notReachable {
                    let sceneToPresent = MainMenu(size: UIScreen.main.bounds.size)
                    prepareForNewScene(sceneToPresent: sceneToPresent, currentScene: self, fadeWithDuration: 1, audioPlayer: nil)
                }else{
                    //They have no internet connection
                    self.connectionTimeOut = true
                    self.makeConnectionBillBoard()
                }
            }
        }else{
            inDebugMode()
        }
    }
    
    func inDebugMode(){
        if debugMode == true {
            let waitForSec = SKAction.wait(forDuration: 3)
            self.run(waitForSec) {
                let sceneToPresent = MainMenu(size: UIScreen.main.bounds.size)
                prepareForNewScene(sceneToPresent: sceneToPresent, currentScene: self, fadeWithDuration: 1, audioPlayer: nil)
            }
        }
    }
}
