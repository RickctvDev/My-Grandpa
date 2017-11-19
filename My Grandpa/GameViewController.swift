//
//  GameViewController.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
        
    private var loaded : Bool = false
    private var sceneIntNumber = 0
    
    override func viewDidLayoutSubviews() {
        //this is where we know if a user has saved data, seems to load up on every scene though
        if UserDefaults.standard.bool(forKey: userHasCompletedTutorial) == true {
            userHasSavedGameFile = true
            print("Has Saved Info")
        }else{
            print("User has nothing saved")
            userHasSavedGameFile = false
        }
        
        if loaded == false {
           
            debugChecker()
            
            if let view = self.view as! SKView? {
                
                //PUT SCENE YOU WANT TO DEBUG HERE
                let scene : BedroomScene!
                scene = BedroomScene(size: UIScreen.main.bounds.size)
                //scene.scaleMode = .aspectFit
                scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                scene.viewController = self
                
                sceneWeAreON = scene
                
                // Present the scene
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
                //view.showsPhysics = true
                
                loaded = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func debugChecker(){
        if debugMode == true {
            print("")
            print("************** DEBUG MODE IS SET TO TRUE *******************")
            print("******** SET TO FALSE BEFORE SUBMITTING THE APP ********")
            print("")
        }else {
            print("")
            print("************** DEBUG MODE IS SET TO FALSE *******************")
            print("************* OK FOR SUBMITTING THE APP ***********")
            print("")
        }
    }
    
    @IBAction func rightSwipe(_ sender: Any) {
   
        let currentSceneName = sceneWeAreON?.name

        var arrayCounter = 0
        for name in layoutOfHouseArray {
            
            if name == currentSceneName {
                sceneIntNumber = arrayCounter + 1
            }else{
                arrayCounter += 1
            }
        }
        sceneChangeSwitcher()
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        let currentSceneName = sceneWeAreON?.name
        
        var arrayCounter = 0
        for name in layoutOfHouseArray {
            
            if name == currentSceneName {
                print(name)
                print(arrayCounter)
                
                if arrayCounter == 0 {
                    
                }else{
                    arrayCounter -= 1
                    sceneIntNumber = arrayCounter - 1
                }
            }
        }
        sceneChangeSwitcher()
    }
    
    func sceneChangeSwitcher(){
        let sceneToGoTo: SKScene!
        
        switch sceneIntNumber {
        case 0:
            sceneToGoTo = BedroomScene(size: UIScreen.main.bounds.size)
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: sceneWeAreON!, fadeWithDuration: 0.5, audioPlayer: nil)
        case 1:
            sceneToGoTo = LivingRoomScene(size: UIScreen.main.bounds.size)
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: sceneWeAreON!, fadeWithDuration: 0.5, audioPlayer: nil)
        case 2:
            sceneToGoTo = BathroomScene(size: UIScreen.main.bounds.size)
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: sceneWeAreON!, fadeWithDuration: 0.5, audioPlayer: nil)
        default:
            print("No Scenes Need to be changed currently from Swipe Gesture")
        }
    }
}
