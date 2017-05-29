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
            
            var nameLabel = SKLabelNode()
            var dateOfBirthLabel = SKLabelNode()
            var racePickedLabel = SKLabelNode()
            var completedTutLabel = SKLabelNode()
            
            if let _nameChosen = userData.getDataFromKey(Key: nameChosen) as? String {
                nameLabel = SKLabelNode(text: "Name Chosen ->  \(_nameChosen)")
            }else {
                nameLabel = SKLabelNode(text: "No Data To Display")
            }
            
            if let _dayChosen = userData.getDataFromKey(Key: dateOfBirthDay) as? String {
                if let _monthChosen = userData.getDataFromKey(Key: dateOfBirthMonth) as? String {
                    dateOfBirthLabel = SKLabelNode(text: "DOB ->  \(_dayChosen) / \(_monthChosen)")
                }
            }else {
                dateOfBirthLabel = SKLabelNode(text: "No Data To Display")
            }
            
            if let _raceChosen = userData.getDataFromKey(Key: racePicked) as? String {
                racePickedLabel = SKLabelNode(text: "Race:  \(_raceChosen)")
            }else {
                racePickedLabel = SKLabelNode(text: "No Data To Display")
            }
            
            if let _tutCompleted = userData.getDataFromKey(Key: userHasCompletedTutorial) as? Bool {
                completedTutLabel = SKLabelNode(text: "Completed Tutorial ->  \(_tutCompleted)")
            }else {
                completedTutLabel = SKLabelNode(text: "No Data To Display")
            }
            
            nameLabel.fontSize = 25
            dateOfBirthLabel.fontSize = nameLabel.fontSize
            racePickedLabel.fontSize = nameLabel.fontSize
            completedTutLabel.fontSize = nameLabel.fontSize
            
            nameLabel.position = CGPoint(x: board.frame.midX, y: board.frame.midX)
            dateOfBirthLabel.position = CGPoint(x: nameLabel.position.x, y: nameLabel.frame.minY - dateOfBirthLabel.frame.size.height)
            racePickedLabel.position = CGPoint(x: dateOfBirthLabel.position.x, y: dateOfBirthLabel.frame.minY - racePickedLabel.frame.size.height)
            completedTutLabel.position = CGPoint(x: racePickedLabel.position.x, y: racePickedLabel.frame.minY - completedTutLabel.frame.size.height)
            
            _scene.addChild(board)
            board.addChild(nameLabel)
            board.addChild(dateOfBirthLabel)
            board.addChild(racePickedLabel)
            board.addChild(completedTutLabel)
            
            let resetButton = SKSpriteNode(color: UIColor.black, size: CGSize(width: 100, height: 50))
            resetButton.name = resetUserDataButtonName
            resetButton.position = CGPoint(x: nameLabel.frame.midX, y: nameLabel.frame.maxY + 50)
            board.addChild(resetButton)
                
            
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
