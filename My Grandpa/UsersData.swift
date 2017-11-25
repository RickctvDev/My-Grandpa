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
        
        print("ALL USER DATA HAS BEEN DELETED")
    }
}





