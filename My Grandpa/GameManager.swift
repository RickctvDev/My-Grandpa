//
//  GAME MANAGER
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
var userConnectedWithLoginCredentials = false // DEFAULT: false
var userHasSavedGameFile = false // DEFAULT: false
var firstTimeLaunchedGame = true

//USER DATA SAVE NAMES
let nameChosen = "nameChosen"
let dateOfBirthDay = "dateOfBirthDay"
let dateOfBirthMonth = "dateOfBirthMonth"
let racePicked = "racePicked"
let userHasCompletedTutorial = "completedTutorial?"
let users_Stamina_Amount = "users_stamina_amount"
let users_Exp_Level = "users_exp_level"
let users_Dollar_Amount = "users_dollar_amount"
let user_Set_Music_Value = "user_set_music_off"
let user_Set_Sound_Value = "user_set_sound_off"
let user_Set_Notifications_Value = "user_set_notifications_off"
var timerForAutoSave = Timer()


//GRANDPAS RACES
let grandpaRaces = ["White", "Black", "Asian", "Brown", "Latino"]

//GAME SETTINGS
let defaultSoundVolume : Float = 0.1
let timeSunRise = 7 // DEFAULT: 7
let timeSunSet = 20 // DEFAULT: 20
let grandpaSleepTime = 22 // DEFAULT: 22
let nightColor = SKColor.black
let nightBlendValue : CGFloat = 0.15 // DEFAULT: 0.15
let nightTimeColorBG = UIColor(red: 25 / 255, green: 74 / 255, blue: 109 / 255, alpha: 1)
let dayTimeColorBG = UIColor(red: 51 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
var itIsDayTime = true
var grandpaIsSleeping = false
var shouldResetNow = false //is used when the game goes into BG
var soundIsOn = true
var otherSoundIsOn = true
var notificationsSwitchedOn = false
var loadedTextField = false
var movedFromAnotherScene = false
var movedToSceneFromLeftArrowTouched = false
var sceneWeAreON : SKScene?
let layoutOfHouseArray = ["Bedroom", "LivingRoom", "Bathroom"]
let livingRoomName = "LivingRoom"
let bedroomName = "Bedroom"
let bathroomName = "Bathroom"


//Game Sprite Names -> Used for testing touches
let houseName = "house"
let groundName = "ground"
let sunName = "sun"
let settingsButtonName = "settingsMenuButton"
let shopButtonName = "shopMenuButton"
let statsButtonName = "statsMenuButton"
let creditsButtonName = "creditsMenuButton"
let moonName = "moon"
let starName = "star"
let cloudName = "cloud"
let createNewGrandpaButtonName = "createGrandpa"
let continueGameButtonName = "continueGame"
let debugButtonName = "debugMode"
let grandpaName = "grandpa"
let fenceName = "FenceLoading"
let billboardName = "BillBoard"
let retryButtonName = "retry"
let mainMenuName = "MainMenu"
let closeButtonName = "closeButton"
let musicButtonName = "musicButton"
let soundButtonName = "soundButton"
let notificationButtonName = "NotificationsButton"
let cameraName = "camera"
let raceNameLabelThatWillBeRemovedWithImagesLater = "raceLabel"
let confirmButtonName = "confirmButton"
let settingsMenuIconName = "settingsMenuIcon"
let calendarImageName = "calendar"
let rightArrowTextureName = "arrow"
let leftArrowTextureName = "arrowLeft"
let rightArrowName = "rightArrow"
let leftArrowName = "leftArrow"
let upArrowName = "upArrow"
let downArrowName = "downArrow"
let upArrow1Name = "upArrow1"
let upArrow2Name = "upArrow2"
let downArrow1Name = "downArrow1"
let downArrow2Name = "downArrow2"
let dayCalenderLabelName = "dayCalLabel"
let monthCalenderLabelName = "monthCalLabel"
let crossButtonName = "cross"
let resetUserDataButtonName = "resetUserDataButton"
let sceneChangeArrowRightName = "sceneChangeRight"
let sceneChangeArrowLeftName = "sceneChangeLeft"

//USEFUL FUNCTIONS AND VARIBLES
var _menuButtonsArray = [MenuButton]()

//Make of size: UIScreen.main.bounds.size
func prepareForNewScene(sceneToPresent : SKScene, currentScene : SKScene, fadeWithDuration : TimeInterval, audioPlayer : AudioMaker?){

    timerForAutoSave.invalidate()
    
    if audioPlayer != nil {
        audioPlayer?.bgMusicFadeOut(withSeconds: fadeWithDuration - 0.8)
    }
    
    currentScene.removeAllActions()
    currentScene.removeAllChildren()
    currentScene.removeFromParent()
    
    if let searchSceneForTextField = currentScene.view?.viewWithTag(999){
        searchSceneForTextField.removeFromSuperview()
    }
    
    sceneToPresent.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    let reveal = SKTransition.fade(withDuration: fadeWithDuration)
    currentScene.view?.presentScene(sceneToPresent, transition: reveal)
    sceneWeAreON = sceneToPresent
}

func randomPointsBetweenWithFloat(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
    return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func randomBetweenNumbersDouble(firstNum: Double, secondNum: Double) -> Double{
    return Double(arc4random()) / Double(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
}

func dayOrNightChecker(){
    let date = Date()
    let calendar = Calendar.current
    let hour = Int(calendar.component(.hour, from: date))
    
    //It is day time
    if hour > timeSunRise && hour < timeSunSet {
        itIsDayTime = true
        grandpaIsSleeping = false
    }else{
        itIsDayTime = false
        if hour >= grandpaSleepTime || hour >= 0 && hour <= timeSunRise {
            grandpaIsSleeping = true
        }
    }
}

