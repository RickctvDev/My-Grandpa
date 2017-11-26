//
//  DebugMenu.swift
//  My Grandpa
//
//  Created by Rick Crane on 02/05/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class DebugMenu : SpriteCreator {
    private let _scene : SKScene!
    private let _texture : String!
    private let _zPosition : CGFloat!
    private let _anchorPoint : CGPoint!
    private let _name : String?
    private var _isDisplayingData = false
    private var board : SKSpriteNode!
    
    override init(scene: SKScene, texture: String?, zPosition: CGFloat, anchorPoints: CGPoint?, name: String?) {
        
        _scene = scene
        _texture = texture
        _zPosition = 5
        _anchorPoint = anchorPoints
        _name = name
        
        super.init(scene: _scene, texture: _texture, zPosition: _zPosition, anchorPoints: _anchorPoint, name: _name)
        
        if debugMode == true {
            self.zPosition = _zPosition
            self.name = _name
            self.size = CGSize(width: 60, height: 25)
            self.color = UIColor.brown
            
            let xPos = _scene.frame.maxX - self.frame.size.width / 2 - 5
            let yPos = _scene.frame.maxY - self.frame.size.height
            self.position = CGPoint(x: xPos, y: yPos)
            
            let label = SKLabelNode(text: "Debug")
            label.fontSize = 15
            label.name = debugButtonName
            label.fontName = "AvenirNext-Bold"
            label.position.y = label.position.y - 4
            label.fontColor = UIColor.black
            label.zPosition = self.zPosition + 1
            
            _scene.addChild(self)
            self.addChild(label)
        }
    }
    
    func showOrRemoveUserSaveData(){
        
        if _isDisplayingData == false {
            let userData = UsersData()
            
            board = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 400, height: 300))
            board.zPosition = 99999
            
            let resetButton = SKSpriteNode(color: UIColor.black, size: CGSize(width: 100, height: 50))
            resetButton.name = resetUserDataButtonName
            resetButton.position = CGPoint(x: board.frame.midX, y: board.frame.maxY - 50)
            board.addChild(resetButton)
            
            var nameLabel = SKLabelNode()
            var dateOfBirthLabel = SKLabelNode()
            var racePickedLabel = SKLabelNode()
            var completedTutLabel = SKLabelNode()
            var users_stamina_level_label = SKLabelNode()
            var users_dollar_amount_label = SKLabelNode()
            var users_exp_level_label = SKLabelNode()
            var users_music_setting_label = SKLabelNode()
            var users_sound_setting_label = SKLabelNode()
            var users_notifications_setting_label = SKLabelNode()
            
            if let _nameChosen = userData.getDataFromKey(Key: nameChosen) as? String {
                nameLabel = SKLabelNode(text: "Name Chosen ->  \(_nameChosen)")
            }else {
                nameLabel = SKLabelNode(text: "Name Chosen -> Empty")
            }
            
            if let _dayChosen = userData.getDataFromKey(Key: dateOfBirthDay) as? String {
                if let _monthChosen = userData.getDataFromKey(Key: dateOfBirthMonth) as? String {
                    dateOfBirthLabel = SKLabelNode(text: "DOB ->  \(_dayChosen) / \(_monthChosen)")
                }
            }else {
                dateOfBirthLabel = SKLabelNode(text: "DOB -> Empty")
            }
            
            if let _raceChosen = userData.getDataFromKey(Key: racePicked) as? String {
                racePickedLabel = SKLabelNode(text: "Race ->  \(_raceChosen)")
            }else {
                racePickedLabel = SKLabelNode(text: "Race -> Empty")
            }
            
            if let _tutCompleted = userData.getDataFromKey(Key: userHasCompletedTutorial) as? Bool {
                completedTutLabel = SKLabelNode(text: "Completed Tutorial ->  \(_tutCompleted)")
            }else {
                completedTutLabel = SKLabelNode(text: "Completed Tut -> False")
            }
            
            if let _users_music_choice = userData.getDataFromKey(Key: user_Set_Music_Value) as? Bool {
                users_music_setting_label = SKLabelNode(text: "Music Off ->  \(_users_music_choice)")
            }else {
                users_music_setting_label = SKLabelNode(text: "Music Off -> Empty")
            }
            
            if let _users_sound_choice = userData.getDataFromKey(Key: user_Set_Sound_Value) as? Bool {
                users_sound_setting_label = SKLabelNode(text: "Sound Off ->  \(_users_sound_choice)")
            }else {
                users_sound_setting_label = SKLabelNode(text: "Sound Off -> Empty")
            }
            
            if let _users_notification_choice = userData.getDataFromKey(Key: user_Set_Notifications_Value) as? Bool {
                users_notifications_setting_label = SKLabelNode(text: "Notification Off ->  \(_users_notification_choice)")
            }else {
                users_notifications_setting_label = SKLabelNode(text: "Notification Off -> Empty")
            }
            
            if userHasSavedGameFile == true {
                let _users_stamina = userData.getDataFromKey(Key: users_Stamina_Amount) as! String
                users_stamina_level_label = SKLabelNode(text: "Users Stamina ->  \(_users_stamina)")
            }else {
                users_stamina_level_label = SKLabelNode(text: "Users Stamina -> Empty")
            }
            
            if userHasSavedGameFile == true {
                let _users_dollars = userData.getDataFromKey(Key: users_Dollar_Amount) as! String
                users_dollar_amount_label = SKLabelNode(text: "Users Dollar ->  \(_users_dollars)")
            }else {
                users_dollar_amount_label = SKLabelNode(text: "Users Dollar -> Empty")
            }
            
            if userHasSavedGameFile == true {
                let _users_experience = userData.getDataFromKey(Key: users_Exp_Level) as! String
                users_exp_level_label = SKLabelNode(text: "Users Exp ->  \(_users_experience)")
            }else {
                users_exp_level_label = SKLabelNode(text: "Users Exp -> Empty")
            }
            
            nameLabel.fontSize = 20
            dateOfBirthLabel.fontSize = nameLabel.fontSize
            racePickedLabel.fontSize = nameLabel.fontSize
            completedTutLabel.fontSize = nameLabel.fontSize
            users_exp_level_label.fontSize = nameLabel.fontSize
            users_dollar_amount_label.fontSize = nameLabel.fontSize
            users_stamina_level_label.fontSize = nameLabel.fontSize
            users_notifications_setting_label.fontSize = nameLabel.fontSize
            users_sound_setting_label.fontSize = nameLabel.fontSize
            users_music_setting_label.fontSize = nameLabel.fontSize
            
            nameLabel.position = CGPoint(x: board.frame.midX, y: resetButton.frame.minY - 20)
            dateOfBirthLabel.position = CGPoint(x: nameLabel.position.x,
                                                y: nameLabel.frame.minY - dateOfBirthLabel.frame.size.height)
            racePickedLabel.position = CGPoint(x: dateOfBirthLabel.position.x,
                                               y: dateOfBirthLabel.frame.minY - racePickedLabel.frame.size.height)
            completedTutLabel.position = CGPoint(x: racePickedLabel.position.x,
                                                 y: racePickedLabel.frame.minY - completedTutLabel.frame.size.height)
            users_exp_level_label.position = CGPoint(x: completedTutLabel.position.x,
                                                     y: completedTutLabel.frame.minY - users_exp_level_label.frame.size.height)
            users_dollar_amount_label.position = CGPoint(x: users_exp_level_label.position.x,
                                                         y: users_exp_level_label.frame.minY - users_dollar_amount_label.frame.size.height)
            users_stamina_level_label.position = CGPoint(x: users_dollar_amount_label.position.x,
                                                         y: users_dollar_amount_label.frame.minY - users_stamina_level_label.frame.size.height)
            users_sound_setting_label.position = CGPoint(x: users_stamina_level_label.position.x,
                                                         y: users_stamina_level_label.frame.minY - users_sound_setting_label.frame.size.height)
            users_music_setting_label.position = CGPoint(x: users_sound_setting_label.position.x,
                                                         y: users_sound_setting_label.frame.minY - users_music_setting_label.frame.size.height)
            users_notifications_setting_label.position = CGPoint(x: users_music_setting_label.position.x,
                                                                 y: users_music_setting_label.frame.minY - users_notifications_setting_label.frame.size.height)
            
            _scene.addChild(board)
            board.addChild(nameLabel)
            board.addChild(dateOfBirthLabel)
            board.addChild(racePickedLabel)
            board.addChild(completedTutLabel)
            board.addChild(users_exp_level_label)
            board.addChild(users_dollar_amount_label)
            board.addChild(users_stamina_level_label)
            board.addChild(users_music_setting_label)
            board.addChild(users_sound_setting_label)
            board.addChild(users_notifications_setting_label)
            
            _isDisplayingData = true
        }else if _isDisplayingData == true {
            board.removeFromParent()
            _isDisplayingData = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
