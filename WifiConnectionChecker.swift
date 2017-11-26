//
//  WifiConnectionChecker.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class WifiConnectionChecker {
    private var wifiImage : SKSpriteNode!
    private var isDisplayingWifiImage = false
    private var wifiDown = false
    var backgroundToStopPlay = SKSpriteNode()
    
    init(onScene : SKScene) {
        if debugMode == false {
            checkInternetConnetionForever(scene: onScene)
            backgroundToStopPlay = SKSpriteNode(color: UIColor.black, size: CGSize(width: onScene.frame.size.width,
                                                                                   height: onScene.frame.size.height))
            backgroundToStopPlay.alpha = 0.65
            backgroundToStopPlay.isHidden = true
            backgroundToStopPlay.zPosition = 1000000000000 - 1
            onScene.addChild(backgroundToStopPlay)
        }
    }
    
    func checkInternetConnetionForever(scene: SKScene){
        
        //If wifi is not down.. make timer start to keep checking
        if wifiDown == false {
            
            //timer is now invoked
            _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                
                //if user has LOST CONNETION
                if self.hasInternetconnection(scene: scene) != true {
                    //stop the timer from continuing
                    timer.invalidate()
                    self.wifiDown = true
                    self.checkingInternetValidation(onScene: scene)
                }
            })
        }
    }
    
    func checkingInternetValidation(onScene : SKScene){
        //HAS NO INTERNET
        var counter = 0
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            counter += 1
            print(counter)
            if self.hasInternetconnection(scene: onScene) == true {
                //User conneted back so we remove the counter
                timer.invalidate()
                self.wifiDown = false
                self.checkInternetConnetionForever(scene: onScene)
            }else{
                if counter >= 20 {
                    //user has not been connected for this many seconds, send them back to loading screen
                    self.goToLoadingScreen(onScene: onScene)
                    timer.invalidate()
                }
            }
        })
    }
    
    func goToLoadingScreen(onScene : SKScene) {
        let newScene = LoadingScreen(size: UIScreen.main.bounds.size)
        wifiImage.removeAllActions()
        wifiImage.removeFromParent()
        newScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let reveal = SKTransition.fade(withDuration: 1)
        onScene.view?.presentScene(newScene, transition: reveal)
    }
    
    func hasInternetconnection(scene : SKScene) -> Bool{
        
        if scene.currentReachabilityStatus != .notReachable{
            //They HAVE internet connection
            print("User Internet Connection Stable")
            displayWifiConnetionMessageOFF()
            backgroundToStopPlay.isHidden = true
            
            
            return true
        }else{
            //They DO NOT have internet connection
            print("User Has Lost Internet Connection")
            displayWifiConnetionMessageON(scene: scene)
            backgroundToStopPlay.isHidden = false
            return false
        }
    }
    
    //USER HAS NO INTERN
    func displayWifiConnetionMessageON(scene :SKScene){
        if isDisplayingWifiImage == false {
            wifiImage = SKSpriteNode(imageNamed: "lowWifiImage")
            scene.addChild(wifiImage)
            positionSprite(scene: scene)
            wifiImage.alpha = 1
            isDisplayingWifiImage = true
            makeActionsForWifiImageMainGame()
        }
    }
    
    func displayWifiConnetionMessageOFF(){
        if wifiImage != nil {
            wifiImage.alpha = 0
            self.wifiImage.removeAllActions()
            isDisplayingWifiImage = false
        }
    }
    
    func positionSprite(scene : SKScene){
        
        self.wifiImage.zPosition = 1000000000000
        self.wifiImage.xScale = 0.2
        self.wifiImage.yScale = self.wifiImage.xScale
        self.wifiImage.position = CGPoint(x: scene.frame.maxX - self.wifiImage.frame.size.width + 15,
                                          y: scene.frame.maxY - self.wifiImage.frame.size.height + 15)
    }
    
    func makeActionsForWifiImageMainGame(){
        let time = 0.7
        let action = SKAction.fadeOut(withDuration: time)
        let reverse = SKAction.fadeIn(withDuration: time)
        let seq = SKAction.sequence([action, reverse])
        let runActionForever = SKAction.repeatForever(seq)
        self.wifiImage.run(runActionForever)
    }
}
