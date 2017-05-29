//
//  MainMenu.swift
//  My Grandpa
//
//  Created by Rick Crane on 25/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit

class MainMenu: SKScene, UITextFieldDelegate {
    
    //SET UP VARIALES
    private var updatables  = [Updatable]()
    private var audioPlayer = AudioMaker()
    private var cam         : Camera!
    private var textInput   : TextField!
    private var debugMode   : DebugMenu!
    
    //NEED THIS TO REMOVE FROM APPDELEGATE
    var viewController: GameViewController!
    
    //NEEDED ACCESS VARIABLES
    private var grandpa         : Grandpa!
    private var startButton     : StartButton!
    private var title           : SKLabelNode!
    private var house           : House!
    private var billBoard       : Billboard!
    private var ground          : Ground!
    private var creationStage   : CreateNewGrandpa!
    
    override func didMove(to view: SKView) {
        let _ : WifiConnectionChecker = WifiConnectionChecker(onScene: self)
        audioPlayer.playBGMusic()
        createMainMenu()
        createGrandpa()
    }
    
    func createMainMenu(){
        self.name = mainMenuName
        testDebugMode()
        dayOrNightChecker() // from game manager
        
        //Create Standard Assets Here
        house = House(scene: self, texture: "house", zPosition: 4, anchorPoints: CGPoint(x: 0.5, y: 0), name: houseName)
        self.addChild(house)
        
        //Create Ground
        ground = Ground(scene: self, texture: "ground", zPosition: 5, anchorPoints: CGPoint(x: 0.5, y: 0), name: groundName)
        self.addChild(ground)
        
        //Show Title
        title = SKLabelNode(text: gameTitleName)
        title.fontName  = gameFont
        title.fontSize  = 40
        title.position  = CGPoint(x: self.frame.midX, y: self.frame.maxY - title.frame.height)
        title.zPosition = 100
        self.addChild(title)
        
        //Show Start Button
        createStartButton()
        
        //Show MenuButtons
        createMenuButtons()
        
        //Customize day or night here
        displayDayOrNight()
        
        //Make Text Field
        makeTextField()
        
        //Make Cam
        makeCam()
    }
    
    //THIS IS BECOMING AN ISSUE
    func makeTextField(){
        self.textInput = TextField(frame: CGRect(x: UIScreen.main.bounds.size.width / 2 + 95,
                                y: UIScreen.main.bounds.size.height / 2 - 70,
                                width: 150,
                                height: 30))
        self.textInput.delegate = self
        self.view?.addSubview(textInput)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //text field is empty
        if textField.text == ""{
            textInput.resignFirstResponder()
            
        }else{
            textInput.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.letters
        
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    
    func displayDayOrNight(){
        if itIsDayTime == true {
            title.fontColor      = SKColor.black
            self.backgroundColor = dayTimeColorBG
            
            //Make Sun
            let sun = Sun(scene: self, texture: "Sun", zPosition: 2, anchorPoints: nil, name: sunName)
            self.addChild(sun)
            
            makeClouds()
            
        }else if itIsDayTime == false {
            title.fontColor      = SKColor.white
            self.backgroundColor = nightTimeColorBG
            
            //Make Moon
            let moon = Moon(scene: self, texture: "moon", zPosition: 80, anchorPoints: nil, name: moonName)
            self.addChild(moon)
            
            //Make 20 Stars and animate
            for _ in 1...20 {
                let star = Star(scene: self, texture: "Star", zPosition: 1, anchorPoints: nil, name : starName)
                self.addChild(star)
                star.makeStarsAnimation()
                
            }
            if grandpaIsSleeping == true && userHasSavedGameFile == true{
                //CHECK TO SEE IF THEY HAVE DATA SAVED
                //THEN MAKE SLEEPING IF THEY HAVE SAVED DATA
                house.makeSleep()
            }
        }
    }
    
    func makeCam(){
        cam = Camera()
        cam.makeCam(scene: self)
        self.addChild(cam)
    }
    
    func createStartButton(){
        if userHasSavedGameFile == false {
            startButton = StartButton(scene: self, texture: "createNewGrandpa", zPosition: 7, anchorPoints: nil, name: createNewGrandpaButtonName)
        }else{
            startButton = StartButton(scene: self, texture: "continueGame", zPosition: 7, anchorPoints: nil, name: continueGameButtonName)
        }
        self.addChild(startButton)
    }
    
    func createGrandpa(){
        grandpa = Grandpa(scene: self, texture: grandpaName, zPosition: 8, anchorPoints: nil , name: grandpaName)
        self.addChild(grandpa)
    }
    
    func createMenuButtons(){
        let settingsMenuButton = MenuButton(scene: self, texture: "SettingsFence", zPosition: 2, anchorPoints: nil, name: settingsButtonName, downFromSpriteNamed: nil)
        self.addChild(settingsMenuButton)
        
        let shopMenuButton = MenuButton(scene: self, texture: "ShopFence", zPosition: 2, anchorPoints: nil, name: shopButtonName, downFromSpriteNamed: settingsButtonName)
        self.addChild(shopMenuButton)
        
        let statsMenuButton = MenuButton(scene: self, texture: "StatsFence", zPosition: 2, anchorPoints: nil, name: statsButtonName, downFromSpriteNamed: shopButtonName)
        self.addChild(statsMenuButton)
        
        let creditsMenuButton = MenuButton(scene: self, texture: "CreditsFence", zPosition: 2, anchorPoints: nil, name: creditsButtonName, downFromSpriteNamed: statsButtonName)
        self.addChild(creditsMenuButton)
    }
    
    func makeClouds(){
        //Create Clouds
        var cloudCounter = 0
        let maxClouds    = 10
        _ = Timer.scheduledTimer(withTimeInterval: randomBetweenNumbersDouble(firstNum: 5, secondNum: 9), repeats: true) { (timer) in
            
            if cloudCounter != maxClouds{
                let cloud = Cloud(scene: self, texture: "cloud", zPosition: 3, anchorPoints: nil, name: cloudName)
                self.updatables.append(cloud)
                self.addChild(cloud)
                
                cloudCounter += 1
            }else{
                timer.invalidate()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            let node     = atPoint(location)
                    
            //If a menu button was selected
            for button in _menuButtonsArray{
                if node.name == button.name!{
                    audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
                    button.menuButtonClicked(buttonSelected: button.name!)
                    makeBillboard(withNodePressed: node.name!, onScene: self)
                    return
                }
            }
            
            if node.name == createNewGrandpaButtonName || node.name == continueGameButtonName {
                //Start Button has been pressed
                startButtonTouched(nodePressed: node)
            }else if node.name == grandpaName {
                //Make hurt sound
                grandpa.playPainVoice()
                return
            }else if node.name == closeButtonName {
                audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
                billBoard.removeBillBoard()
                createMenuButtons()
                return
            }else if node.name == notificationButtonName{
                audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
                billBoard.turnOnOffNotifications()
            }else if node.name == musicButtonName{
                audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
                billBoard.turnOnOffMainMusic()
                audioPlayer.turnMusicOffOrOn()
            }else if node.name == soundButtonName{
                audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
                billBoard.turnOnOffButtonSounds()
            }else if node.name == confirmButtonName{
                audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
                creationStage.confirmButtonPressed()
                if userHasSavedGameFile  == true{
                    audioPlayer.bgMusicFadeOut(withSeconds: 1)
                    grandpa.userCompletedTutorial()
                }
            }else if node.name == upArrow1Name
                || node.name == upArrow2Name
                || node.name == downArrow1Name
                || node.name == downArrow2Name
                || node.name == rightArrowName
                || node.name == leftArrowName
            {
                audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
                creationStage.arrowWasPressed(node: node)
            }else if node.name == crossButtonName {
                creationStage.resetStages()
            }else if node.name == debugButtonName {
                debugMode.showOrRemoveUserSaveData()
            }else if node.name == resetUserDataButtonName {
                let userData = UsersData()
                userData.removeAllUserData()
            }
        }
    }
    
    func startButtonTouched(nodePressed: SKNode){
        audioPlayer.playButtonClickSound(scene: self, atVolume: defaultSoundVolume)
        
        //StarButton Action
        startButton.startGameButtonPressed(nodePressed: nodePressed, camNode: cam)
        
        //Remove Menu Buttons
        for button in _menuButtonsArray{
            button.removeAllButtonsFromScene()
        }
        
        if nodePressed.name == continueGameButtonName {
            audioPlayer.bgMusicFadeOut(withSeconds: 2)
            
            let waitTimer = SKAction.wait(forDuration: 3.7)
            grandpa.continueButtonPressed()
            house.openAndCloseHouse(waitForDuration: 1.8)
            self.run(waitTimer) {
                let sceneToGoTo = LivingRoomScene(size: UIScreen.main.bounds.size)
                prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: self, fadeWithDuration: 0.5, audioPlayer: nil)
            }
        }else if nodePressed.name == createNewGrandpaButtonName {
            house.openAndCloseHouse(waitForDuration: 0.3)
            grandpa.createButtonPressed(toPos: CGPoint(x: house.frame.maxX + 75, y: grandpa.position.y), timeToMove: 1)
            creationStage = CreateNewGrandpa(onScene: self, textFieldToPass: textInput, camera: cam)
            creationStage.startStage1(withTime: 2)
        }
    }
    
    func makeBillboard(withNodePressed: String, onScene: SKScene){
        billBoard = Billboard(scene: self, texture: billboardName, zPosition: 12, anchorPoints: nil, name: billboardName)
        
        billBoard.showBillBoard(nodeName: withNodePressed, onScene: self)
        self.addChild(billBoard)
    }
    
    //DEBUG MODE CHECKER
    func testDebugMode(){
        debugMode = DebugMenu(scene: self, texture: "wallpaper3", zPosition: 1999, anchorPoints: nil, name: debugButtonName)
        debugMode.alpha = 1 
    }
    
    override func update(_ currentTime: TimeInterval) {        
        updatables.forEach { $0.update(currentTime: currentTime) }
        if shouldResetNow == true {
            shouldResetNow  = false
            let sceneToGoTo = LoadingScreen(size: UIScreen.main.bounds.size)
            prepareForNewScene(sceneToPresent: sceneToGoTo, currentScene: self, fadeWithDuration: 0.5, audioPlayer: audioPlayer)
            
        }
    }
}
