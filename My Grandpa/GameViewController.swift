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
    
    override func viewDidLayoutSubviews() {
        debugChecker()
        
        if let view = self.view as! SKView? {
            
            //PUT SCENE YOU WANT TO DEBUG HERE
            let scene : LoadingScreen!
            scene = LoadingScreen(size: UIScreen.main.bounds.size)
            //scene.scaleMode = .aspectFit
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            // Present the scene
            view.presentScene(scene)
    
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            //view.showsPhysics = true
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
        print("********************DEBUG MODE IS SET TO TRUE -> SET TO FALSE BEFORE SUBMITTING THE APP*****************")
    }
}
