//
//  UserData.swift
//  My Grandpa
//
//  Created by Rick Crane on 22/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation

struct UsersData{
    //User Data Key Values
    private let USERS_DATA = UserDefaults.standard
    
    func getDataFromKey(Key : String) -> Any{
        
        return USERS_DATA.object(forKey: Key) ?? "Empty"
    }
    
    func saveData(KeyName: String, dataToPass: Any){
        USERS_DATA.set(dataToPass, forKey: KeyName)
        USERS_DATA.synchronize()
    }
    
    func removeAllUserData(){
        USERS_DATA.removeObject(forKey: nameChosen)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: dateOfBirthDay)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: dateOfBirthMonth)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: racePicked)
        USERS_DATA.synchronize()
        USERS_DATA.set(false, forKey: userHasCompletedTutorial)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: users_Stamina_Amount)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: user_Set_Notifications_Value)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: user_Set_Sound_Value)
        USERS_DATA.synchronize()
        USERS_DATA.removeObject(forKey: user_Set_Music_Value)
        USERS_DATA.synchronize()
        
        
        print("ALL USER DATA HAS BEEN DELETED")
    }
    
    func grabUsersCurrentSettingsData(){
        
        //FIRST TIME LAUNCHED APP -> PLACE SOME VALUES IN PHONE
        if firstTimeLaunchedGame == true{
            saveData(KeyName: user_Set_Notifications_Value, dataToPass: false)
            saveData(KeyName: user_Set_Music_Value, dataToPass: true)
            saveData(KeyName: user_Set_Sound_Value, dataToPass: true)
            
            soundIsOn = true
            otherSoundIsOn = true
            notificationsSwitchedOn = false
            
            //USER HAS PLAYED BEFORE, GRAB THEIR SAVED FILES
        }else if userHasSavedGameFile == true {
            firstTimeLaunchedGame = false
            
            //SOUNDS IF OFF?
            if getDataFromKey(Key: user_Set_Sound_Value) as! Bool == true {
                otherSoundIsOn = true
            }else{
                otherSoundIsOn = false
            }
            
            //MUSIC IF OFF?
            if getDataFromKey(Key: user_Set_Music_Value) as! Bool ==  true {
                soundIsOn = true
            }else{
                soundIsOn = false
            }
            
            //NOTIFICATIONS ARE OFF?
            if getDataFromKey(Key: user_Set_Notifications_Value) as! Bool == true {
                notificationsSwitchedOn = true
            }else{
                notificationsSwitchedOn = false
            }
        }else{
            print("SOMETHING IS WRONG")
        }
    }
}





