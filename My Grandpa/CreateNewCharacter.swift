//
//  CreateNewCharacter.swift
//  My Grandpa
//
//  Created by Rick Crane on 17/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class CreateNewGrandpa {
    
    //MUST HAVE VARIABLES
    private var stageDescriptionLabel : SKLabelNode = SKLabelNode(fontNamed: gameFont)
    private let _scene : SKScene!
    private var rightArrow : Arrow!
    private var leftArrow : Arrow!
    private var upArrow1 : Arrow!
    private var upArrow2 : Arrow!
    private var downArrow1 : Arrow!
    private var downArrow2 : Arrow!
    private var confirmButton : SpriteCreator!
    private var daycal : SpriteCreator!
    private var monthCal : SpriteCreator!
    private let textFieldFromView : UITextField!
    private let userData = UsersData()
    private var monthCounter : Int = 1
    private var dayCounter : Int = 1
    private var maxCountForCalendar : Int = 28
    private var raceCounterPos : Int = 0
    private var cameraFirstPos = CGPoint()
    private var hasRestartedTut = false
    
    //CALENDAR VARIABLES
    let months: [Int:String] = [
        1 : "Jan", // HAS 31 D
        2 : "Feb", // HAS 28 D
        3 : "Mar", // HAS 31 D
        4 : "Apr", // HAS 30 D
        5 : "May", // HAS 31 D
        6 : "Jun", // HAS 30 D
        7 : "Jul", // HAS 31 D
        8 : "Aug", // HAS 31 D
        9 : "Sep", // HAS 30 D
        10 : "Oct", // HAS 31 D
        11 : "Nov", // HAS 30 D
        12 : "Dec" // HAS 31 D
    ]
    
    let monthsStringToInt : [String:Int] = [
        "Jan" : 1, // HAS 31 D
        "Feb" : 2, // HAS 28 D
        "Mar" : 3, // HAS 31 D
        "Apr" : 4, // HAS 30 D
        "May" : 5, // HAS 31 D
        "Jun" : 6, // HAS 30 D
        "Jul" : 7, // HAS 31 D
        "Aug" : 8, // HAS 31 D
        "Sep" : 9, // HAS 30 D
        "Oct" : 10, // HAS 31 D
        "Nov" : 11, // HAS 30 D
        "Dec" : 12 // HAS 31 D
    ]
    
    //USEFUL VARIABLES
    private var onStageNumber : Int = 1
    private let calendarImageSize : CGFloat = 0.05
    private var raceLabel : SKLabelNode!
    
    //FINDING SPRITES VARIABLES
    private let findGrandpaSprite : Grandpa
    private let findGroundSprite : Ground
    private let cam : Camera!
    private var dayCalLabel : SKLabelNode!
    private var monthCalLabel : SKLabelNode!
    
    init(onScene : SKScene, textFieldToPass : UITextField, camera: Camera){
        self._scene = onScene
        textFieldFromView = textFieldToPass
        findGrandpaSprite = _scene.childNode(withName: grandpaName) as! Grandpa
        findGroundSprite  = _scene.childNode(withName: groundName) as! Ground
        cam = camera
    }
    
    private func completedTutorial(){
        //REMOVE EVERYTHING FROM THE FINAL STAGE
        textFieldFromView.removeFromSuperview()
        _scene.childNode(withName: "dob")?.removeFromParent()
        _scene.childNode(withName: "name")?.removeFromParent()
        _scene.childNode(withName: "cross")?.removeFromParent()
        confirmButton.removeFromParent()
        raceLabel.removeFromParent()
        stageDescriptionLabel.removeFromParent()
        
        userHasSavedGameFile = true
    }
    
    private func cancelButtonPressed(){
        //REMOVE EVERYTHING FROM THE FINAL STAGE
        _scene.childNode(withName: "dob")?.removeFromParent()
        _scene.childNode(withName: "name")?.removeFromParent()
        _scene.childNode(withName: "cross")?.removeFromParent()
        stageDescriptionLabel.removeFromParent()
        raceLabel.removeFromParent()
        confirmButton.removeFromParent()
    }
    
    private func startStage4(){
        //CONFIRM SELECTION STAGE
        
        //REMOVE THE THIRD STAGE SPRITES AND HIDE TEXT FIELD
        textFieldFromView.isHidden = true
        
        //MOVE CAMERA TO POS
        let pos = CGPoint(x: cam.position.x - 60, y: cam.position.y)
        cam.moveToPos(position: pos, withTime: 0.3, withZoom: nil)
        
        //CHANGE THE TUTORIAL LABEL
        changeDescriptionLabelTo(description: "Is This All Correct?", pos: CGPoint(x: findGrandpaSprite.frame.maxX + 50,
                                                                                   y: findGrandpaSprite.frame.maxY), fontSize: 12)
        
        //SHOW FINAL RESULTS
        //DATE OF BIRTH LABEL
        let dateOfBirthLabel = SKLabelNode(fontNamed: gameFont)
        let dayToDisplay = userData.getDataFromKey(Key: dateOfBirthDay)
        let checkMonth = userData.getDataFromKey(Key: dateOfBirthMonth)
        dateOfBirthLabel.text = "DOB : \(dayToDisplay) \(checkMonth)"
        dateOfBirthLabel.name = "dob"
        dateOfBirthLabel.fontSize = 12
        dateOfBirthLabel.fontColor = UIColor.black
        dateOfBirthLabel.position = CGPoint(x: stageDescriptionLabel.frame.midX, y: stageDescriptionLabel.frame.minY - 40)
        _scene.addChild(dateOfBirthLabel)
        
        //NAME CHOSEN LABEL
        let name = SKLabelNode(fontNamed: gameFont)
        let check = userData.getDataFromKey(Key: nameChosen)
        name.name = "name"
        name.text = "Name : \(check)"
        name.fontSize = dateOfBirthLabel.fontSize
        name.fontColor = dateOfBirthLabel.fontColor
        name.position = CGPoint(x: dateOfBirthLabel.position.x, y: dateOfBirthLabel.frame.minY - 20)
        
        if itIsDayTime == false {
            let white = SKColor.white
            dateOfBirthLabel.fontColor = white
            name.fontColor = white
        }
        
        _scene.addChild(name)
        
        //MAKE CANCEL BUTTON
        let crossButton = SpriteCreator(scene: _scene, texture: crossButtonName, zPosition: confirmButton.zPosition, anchorPoints: nil, name: crossButtonName)
        crossButton.xScale = 0.04
        crossButton.yScale = crossButton.xScale
        crossButton.position = CGPoint(x: name.frame.midX - crossButton.frame.size.width,
                                    y: name.frame.minY - 35)
        _scene.addChild(crossButton)
        
        //MOVE CONFIRM BUTTON
        confirmButton.position = CGPoint(x: crossButton.position.x + crossButton.frame.size.width * 2,
                                                                         y: crossButton.position.y)
    }
    
    private func moveToNextStage(){
        if onStageNumber == 1 {
            print("On Stage 1")
        }else if onStageNumber == 2 {
            startStage2()
        }else if onStageNumber == 3 {
            startStage3()
        }else if onStageNumber == 4 {
            saveSelection()
            startStage4()
        }else if onStageNumber == 5{
            print("YOU HAVE COMPLETED THE TUTORIAL")
            saveSelection()
        }else{
            print("Switch stage has an error ->>>>> under create new grandpa class")
        }
    }
    
    private func startStage3(){
        //CREATE NAME OF GRANPA STAGE
        
        //REMOVE THE SECOND STAGE SPRITES
        upArrow1.removeFromParent()
        upArrow2.removeFromParent()
        downArrow1.removeFromParent()
        downArrow2.removeFromParent()
        monthCal.removeFromParent()
        daycal.removeFromParent()
        
        //MOVE CAMERA TO POS
        let pos = CGPoint(x: cam.position.x + 60, y: cam.position.y)
        cam.moveToPos(position: pos, withTime: 0.3, withZoom: nil)
        
        //CHANGE THE TUTORIAL LABEL
        changeDescriptionLabelTo(description: "Choose His Name", pos: CGPoint(x: findGrandpaSprite.frame.maxX + stageDescriptionLabel.frame.size.width,
                                                               y: stageDescriptionLabel.position.y - 30), fontSize: 12)
        
        //POSITION THE CONFIRM BUTTON
        confirmButton.position = CGPoint(x: stageDescriptionLabel.position.x,
                                         y: findGrandpaSprite.frame.midY - 30)
        
        let wait = SKAction.wait(forDuration: 0.3)
        _scene.run(wait, completion: {
            self.textFieldFromView.isHidden = false
        })
    }
    
    private func startStage2(){
        //CREATE BIRTHDAY STAGE
        
        //REMOVE THE FIRST STAGE ARROWS
        rightArrow.removeFromParent()
        leftArrow.removeFromParent()
        
        //MOVE CAMERA TO POS
        let pos = CGPoint(x: cam.position.x + 40, y: cam.position.y)
        cam.moveToPos(position: pos, withTime: 0.3, withZoom: nil)
        
        //MAKE NEW ARROWS
        makeArrows()
        
        //MOVE CONFIRM BUTTON
        confirmButton.position = CGPoint(x: downArrow1.position.x + downArrow1.frame.size.width, y: downArrow1.position.y - downArrow1.frame.size.height)
        
        //CHANGE THE TUTORIAL LABEL
        changeDescriptionLabelTo(description: "Choose his Birthday", pos: CGPoint(x: upArrow1.position.x + upArrow1.frame.size.width,
                                                                                  y: stageDescriptionLabel.position.y), fontSize: 10)
        
        //CREATE CALENDARS TO PICK DATE OF BIRTH
        daycal = SpriteCreator(scene: _scene, texture: calendarImageName, zPosition: 100, anchorPoints: nil, name: calendarImageName)
        daycal.xScale = calendarImageSize
        daycal.yScale = calendarImageSize
        
        monthCal = SpriteCreator(scene: _scene, texture: calendarImageName, zPosition: 100, anchorPoints: nil, name: calendarImageName)
        monthCal.xScale = calendarImageSize
        monthCal.yScale = calendarImageSize
        
        daycal.position = CGPoint(x: upArrow1.position.x,
                                  y: upArrow1.frame.minY - upArrow1.frame.size.height / 1.5)
        
        monthCal.position = CGPoint(x: upArrow2.position.x,
                                    y: daycal.position.y)
        
        _scene.addChild(daycal)
        _scene.addChild(monthCal)
        
        dayCalLabel = SKLabelNode(fontNamed: gameFont)
        monthCalLabel = SKLabelNode(fontNamed: gameFont)
        
        makeLabel(withText: "DD", onSprite: daycal, withName: dayCalenderLabelName, usingLabelNode : dayCalLabel)
        makeLabel(withText: "MM", onSprite: monthCal, withName: monthCalenderLabelName, usingLabelNode: monthCalLabel)
    }
    
    private func makeLabel(withText : String, onSprite: SKSpriteNode, withName: String, usingLabelNode : SKLabelNode){
        usingLabelNode.text = withText
        usingLabelNode.fontName = gameFont
        usingLabelNode.zPosition = 200
        usingLabelNode.fontColor = SKColor.black
        usingLabelNode.fontSize = 300
        //label.position = pos
        usingLabelNode.position.x = onSprite.frame.midX
        usingLabelNode.position.y = onSprite.frame.minY - 120
        onSprite.addChild(usingLabelNode)
    }
    
    private func changeDescriptionLabelTo(description : String, pos : CGPoint, fontSize : CGFloat){
        //CHANGE THE TUTORIAL LABEL
        stageDescriptionLabel.text = description
        stageDescriptionLabel.fontSize = fontSize
        stageDescriptionLabel.position = pos
    }
    
    func confirmButtonPressed(){
        
        if onStageNumber == 2{
            if dayCalLabel.text == "DD"{
                self.findGrandpaSprite.playAngryVoice()
            }else{
                onStageNumber += 1
                moveToNextStage()
            }
        }else if onStageNumber == 3 && (textFieldFromView.text?.isEmpty)! {
            self.findGrandpaSprite.playAngryVoice()
        }else{
            onStageNumber += 1
            moveToNextStage()
        }
        print("On Stage Number \(onStageNumber)")
    }
    
    private func saveSelection(){
        print("On stage number -> \(onStageNumber)")
        
        if onStageNumber == 4 {
            userData.saveData(KeyName: racePicked, dataToPass: grandpaRaces[raceCounterPos])
            if let dateOfBirth = dayCalLabel.text{
                userData.saveData(KeyName: dateOfBirthDay, dataToPass: dateOfBirth)
            }
            if let monthOfBirth = monthCalLabel.text{
                userData.saveData(KeyName: dateOfBirthMonth, dataToPass: monthOfBirth)
            }
            if let nameOfGrandpa = textFieldFromView.text?.capitalized {
                userData.saveData(KeyName: nameChosen, dataToPass: nameOfGrandpa)
            }
            userData.grabUsersCurrentSettingsData()
            
        }else if onStageNumber == 5 {
            userData.saveData(KeyName: userHasCompletedTutorial, dataToPass: true)
            completedTutorial()
        }
    }
    
    func resetStages(){
        onStageNumber = 1
        cancelButtonPressed()
        startStage1(withTime: 0.2)
        userData.removeAllUserData()
        findGrandpaSprite.playAngryVoice()
    }
    
    private func makeConfirmButton(){
        confirmButton = SpriteCreator(scene: _scene, texture: confirmButtonName, zPosition: 116, anchorPoints: nil, name: confirmButtonName)
        confirmButton.size = rightArrow.size
        confirmButton.position = CGPoint(x: rightArrow.position.x, y: findGroundSprite.frame.maxY + 15)
        
        _scene.addChild(confirmButton)
    }
    
    private func makeArrows(){
        
        if onStageNumber == 1 {
            rightArrow = Arrow(scene: _scene, texture: rightArrowTextureName, zPosition: 115, anchorPoints: nil, name: rightArrowName)
            leftArrow = Arrow(scene: _scene, texture: leftArrowTextureName, zPosition: 115, anchorPoints: nil, name: leftArrowName)
            
            rightArrow.position = CGPoint(x: findGrandpaSprite.frame.maxX + 30,
                                          y: findGrandpaSprite.frame.midY + 20)
            leftArrow.position = CGPoint(x: findGrandpaSprite.frame.minX - 30,
                                         y: rightArrow.position.y)
            
            _scene.addChild(rightArrow)
            _scene.addChild(leftArrow)
        }else if onStageNumber == 2{
            //MAKE NEW ARROWS
            upArrow1 = Arrow(scene: _scene, texture: upArrowName, zPosition: 115, anchorPoints: nil, name: upArrow1Name)
            downArrow1 = Arrow(scene: _scene, texture: downArrowName, zPosition: 115, anchorPoints: nil, name: downArrow1Name)
            upArrow2 = Arrow(scene: _scene, texture: upArrowName, zPosition: 115, anchorPoints: nil, name: upArrow2Name)
            downArrow2 = Arrow(scene: _scene, texture: downArrowName, zPosition: 115, anchorPoints: nil, name: downArrow2Name)
            
            //POSITION ARROWS
            upArrow1.position = CGPoint(x: findGrandpaSprite.frame.maxX + 30,
                                        y: findGrandpaSprite.frame.midY + upArrow1.frame.size.height * 2)
            upArrow2.position = CGPoint(x: upArrow1.position.x + upArrow2.frame.size.width * 2,
                                        y: upArrow1.position.y)
            
            downArrow1.position = CGPoint(x: upArrow1.position.x,
                                          y: findGrandpaSprite.frame.midY - 15)
            downArrow2.position = CGPoint(x: downArrow1.position.x + downArrow2.frame.size.width * 2,
                                          y: downArrow1.position.y)
            
            //ADD NEW ARROWS
            _scene.addChild(upArrow1)
            _scene.addChild(downArrow1)
            _scene.addChild(upArrow2)
            _scene.addChild(downArrow2)
        }
    }
    
    func startStage1(withTime: Double){
        //Make Timer for this to spawn
        let waitTimer = SKAction.wait(forDuration: withTime)
        _scene.run(waitTimer){
            self.makeTEMPRaceLabel() // need to remove this at some point
            self.makeDescriptonLabel()
            self.makeArrows()
            self.makeConfirmButton()
            
            if self.hasRestartedTut == false {
                self.hasRestartedTut = true
                self.cameraFirstPos = self.cam.position
            }else{
                self.cam.moveToPos(position: self.cameraFirstPos, withTime: 0.2, withZoom: nil)
            }
        }
    }
    
    private func makeDescriptonLabel(){
        
        stageDescriptionLabel = SKLabelNode(fontNamed: gameFont)
        stageDescriptionLabel.fontSize = 15
        stageDescriptionLabel.zPosition = 20
        stageDescriptionLabel.text = "Choose Grandpas Race"
        
        stageDescriptionLabel.position = CGPoint(x: findGrandpaSprite.frame.midX,
                                                 y: findGrandpaSprite.frame.maxY + 25)
        
        if itIsDayTime == false{
            stageDescriptionLabel.fontColor = SKColor.white
        }
        
        _scene.addChild(stageDescriptionLabel)
    }
    
    private func makeTEMPRaceLabel(){
        raceLabel = SKLabelNode(fontNamed: gameFont) //This needs to be deleted once we have the images
        self.raceLabel.name = raceNameLabelThatWillBeRemovedWithImagesLater
        self.raceLabel.fontColor = SKColor.black
        self.raceLabel.fontSize = 15
        self.raceLabel.zPosition = 20
        
        self.raceLabel.text = grandpaRaces[0]
        
        self.raceLabel.position = CGPoint(x: findGrandpaSprite.frame.midX,
                                          y: findGrandpaSprite.frame.maxY + 10)
        
        _scene.addChild(self.raceLabel)
    }
    
    func arrowWasPressed(node : SKNode){
        let grandpaRaceArrayAmount = grandpaRaces.count - 1

        //IF UP AND DOWN ARROWS ARE ON THE SCREEN
        if upArrow1 != nil && onStageNumber != 1{
            if node.name == upArrow1.name {
                //Is DAY Cal Up
                if dayCounter >= maxCountForCalendar || dayCalLabel.text == "DD"{
                    dayCounter = 1
                }else{
                    dayCounter += 1
                }
                monthTester()
                
            }else if node.name == upArrow2.name {
                //is MONTH Cal Up
                if monthCounter >= 12{
                    monthCounter = 1
                }else{
                    monthCounter += 1
                }
                monthTester()
                
            }else if node.name == downArrow1.name {
                //is DAY Cal Down
                if dayCounter <= 1 || dayCalLabel.text == "DD"{
                    dayCounter = maxCountForCalendar
                }else{
                    dayCounter -= 1
                }
                monthTester()
                
            }else if node.name == downArrow2.name {
                //is MONTH Cal Down
                if monthCounter <= 1 {
                    monthCounter = 12
                }else{
                    monthCounter -= 1
                }
                monthTester()
            }
            
            //IF UP LEFT AND RIGHT ARROWS ARE ON THE SCREEN
        }else if leftArrow != nil {
            if node.name == leftArrow.name {
                //On the Race Selection  LEFT
                
                if raceCounterPos <= 0 {
                    raceCounterPos = grandpaRaceArrayAmount
                    raceLabel.text = "\(grandpaRaces[raceCounterPos])"
                }else{
                    raceCounterPos -= 1
                    raceLabel.text = "\(grandpaRaces[raceCounterPos])"
                }
            }else if node.name == rightArrow.name {
                //On the Race Selection Right
                if raceCounterPos >= grandpaRaceArrayAmount{
                    raceCounterPos = 0
                    raceLabel.text = "\(grandpaRaces[raceCounterPos])"
                }else{
                    raceCounterPos += 1
                    raceLabel.text = "\(grandpaRaces[raceCounterPos])"
                }
            }
        }
    }
    
    private func monthTester(){
        //IF MONTH HAS 31 DAYS
        if monthCounter == monthsStringToInt["Jan"]
            || monthCounter == monthsStringToInt["Mar"]
            || monthCounter == monthsStringToInt["May"]
            || monthCounter == monthsStringToInt["Jul"]
            || monthCounter == monthsStringToInt["Aug"]
            || monthCounter == monthsStringToInt["Oct"]
            || monthCounter == monthsStringToInt["Dec"]
        {
            maxCountForCalendar = 31
            refreshLabel()
            
            //IF MONTH IS IN FEB
        }else if monthCounter == monthsStringToInt["Feb"]
        {
            maxCountForCalendar = 28
            dayCalLabel.text = "28"
            refreshLabel()
            
            //IF MONTH HAS 30 DAYS
        }else if monthCounter == monthsStringToInt["Apr"]
            || monthCounter == monthsStringToInt["Jun"]
            || monthCounter == monthsStringToInt["Sep"]
            || monthCounter == monthsStringToInt["Nov"]
        {
            maxCountForCalendar = 30
            refreshLabel()
        }
    }
    
    private func refreshLabel(){
        if dayCounter >= maxCountForCalendar {
            dayCounter = maxCountForCalendar
        }
        dayCalLabel.text = "\(dayCounter)"
        monthCalLabel.text = months[monthCounter]
    }
}
