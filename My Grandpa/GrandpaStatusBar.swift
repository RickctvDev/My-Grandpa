//
//  GrandpaStatusBar.swift
//  My Grandpa
//
//  Created by Rick Crane on 24/09/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import SpriteKit

class GrandpaStatusBar : SKSpriteNode{
    
    private let _scene : SKScene!
    private let _name : String?
    
    let grandpaExpLevelLabel = SKLabelNode(fontNamed: gameFont)
    let dollarAmountValue = SKLabelNode(fontNamed: gameFont)
    let staminaAmountValue = SKLabelNode(fontNamed: gameFont)
    
    init(scene: SKScene, name: String?, texture: SKTexture?, withSize: CGSize) {
        _scene = scene
        _name = name
        
        super.init(texture: nil, color: .clear, size: CGSize(width: 200, height: 100))
        
        self.anchorPoint = CGPoint(x: 0, y: 1)
        self.zPosition = 600
        self.name = "Status bar"
        
        //Changeable Values
        let progressBarSize = CGRect(x: 0, y: 0, width: self.frame.size.width / 2, height: self.frame.size.height / 12)
        let borderColor = UIColor.black
        let borderThickness : CGFloat = 2
        let spaceBetween : CGFloat = 2
        let roundIconSizes : CGFloat = 20
        let emojiSizes : CGSize = CGSize(width: 20, height: 20)
        
        //Making the stamina/progres bars here
        let healthBar = SKShapeNode(path: CGPath(roundedRect: progressBarSize, cornerWidth: 2, cornerHeight: 0, transform: nil))
        healthBar.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - healthBar.frame.height)
        healthBar.fillColor = UIColor.red
        healthBar.strokeColor = borderColor
        healthBar.lineWidth = borderThickness
        self.addChild(healthBar)
        
        let healthEmoji = SpriteCreator(scene: scene, texture: "heart", zPosition: 500, anchorPoints: nil, name: "health")
        healthEmoji.size = emojiSizes
        healthEmoji.position = CGPoint(x: healthBar.frame.maxX + healthEmoji.frame.size.width / 2, y: healthBar.frame.midY)
        self.addChild(healthEmoji)
        
        let hungerBar = SKShapeNode(path: CGPath(roundedRect: progressBarSize, cornerWidth: 2, cornerHeight: 0, transform: nil))
        hungerBar.position = CGPoint(x: healthBar.position.x, y: healthBar.position.y - (hungerBar.frame.height * spaceBetween))
        hungerBar.fillColor = UIColor.blue
        hungerBar.strokeColor = borderColor
        hungerBar.lineWidth = borderThickness
        self.addChild(hungerBar)
        
        let hungerEmoji = SpriteCreator(scene: scene, texture: "meat", zPosition: 500, anchorPoints: nil, name: "hunger")
        hungerEmoji.size = emojiSizes
        hungerEmoji.position = CGPoint(x: hungerBar.frame.maxX + hungerEmoji.frame.size.width / 2, y: hungerBar.frame.midY)
        self.addChild(hungerEmoji)
        
        let happinessBar = SKShapeNode(path: CGPath(roundedRect: progressBarSize, cornerWidth: 2, cornerHeight: 0, transform: nil))
        happinessBar.position = CGPoint(x: hungerBar.position.x, y: hungerBar.position.y - (happinessBar.frame.height * spaceBetween))
        happinessBar.fillColor = UIColor.green
        happinessBar.strokeColor = borderColor
        happinessBar.lineWidth = borderThickness
        self.addChild(happinessBar)
        
        let happyEmoji = SpriteCreator(scene: scene, texture: "happy", zPosition: 500, anchorPoints: nil, name: "happy")
        happyEmoji.size = emojiSizes
        happyEmoji.position = CGPoint(x: happinessBar.frame.maxX + happyEmoji.frame.size.width / 2, y: happinessBar.frame.midY)
        self.addChild(happyEmoji)
        
        //This is the Exp Level Icon being made
        let levelIcon = SKShapeNode(circleOfRadius: roundIconSizes)
        levelIcon.fillColor = #colorLiteral(red: 0.6246983409, green: 0.4447562695, blue: 0.2899751961, alpha: 1)
        levelIcon.position = CGPoint(x: hungerBar.position.x - levelIcon.frame.size.width / 2 - 3, y: hungerBar.frame.midY)
        levelIcon.strokeColor = borderColor
        levelIcon.lineWidth = borderThickness + 2
        self.addChild(levelIcon)
        
        //This is the Exp Level Grandpa is on
        grandpaExpLevelLabel.zPosition = levelIcon.zPosition + 1
        grandpaExpLevelLabel.fontSize = 25
        grandpaExpLevelLabel.fontColor = .black
        grandpaExpLevelLabel.text = "100"
        levelIcon.addChild(grandpaExpLevelLabel)
        
        //LEAVE THIS HERE, OTHERWISE YOU BREAK IT
        self.position = CGPoint(x: scene.frame.minX - self.frame.size.width / 4, y: scene.frame.maxY - 10)
        
        //Making Dollar Icon
        let dollarIcon = SKShapeNode(circleOfRadius: roundIconSizes)
        dollarIcon.fillColor = .white
        dollarIcon.fillTexture = SKTexture(imageNamed: "dollar")
        dollarIcon.position = CGPoint(x: self.frame.maxX + dollarIcon.frame.size.width * 2,
                                      y: self.frame.maxY - healthBar.frame.height * (spaceBetween) - 5)
        dollarIcon.strokeColor = borderColor
        dollarIcon.zPosition = self.zPosition
        dollarIcon.lineWidth = borderThickness + 2
        scene.addChild(dollarIcon)
        
        let dollarNoteIcon = SpriteCreator(scene: scene, texture: "dollarNote", zPosition: 500, anchorPoints: nil, name: "dollarNoteActual")
        dollarNoteIcon.xScale = 0.15
        dollarNoteIcon.yScale = dollarNoteIcon.xScale
        dollarNoteIcon.zPosition = 499
        dollarNoteIcon.position = CGPoint(x: dollarIcon.frame.maxX + 15, y: dollarIcon.position.y)
        scene.addChild(dollarNoteIcon)
        
        //This is the dollar amount user has
        dollarAmountValue.zPosition = dollarNoteIcon.zPosition + 1
        dollarAmountValue.fontSize = 150
        dollarAmountValue.fontColor = .black
        dollarAmountValue.text = "999.9k"
        dollarAmountValue.position = CGPoint(x: dollarAmountValue.position.x + 45, y: -45)
        dollarNoteIcon.addChild(dollarAmountValue)
        
        
        //Making Stamina Icon
        let staminaIcon = SpriteCreator(scene: scene, texture: "bottle", zPosition: 500, anchorPoints: nil, name: "bottle")
        staminaIcon.xScale = 0.13
        staminaIcon.yScale = staminaIcon.xScale
        staminaIcon.zPosition = 500
        staminaIcon.position = CGPoint(x: scene.frame.midX + staminaIcon.frame.size.width, y: dollarIcon.position.y)
        scene.addChild(staminaIcon)
        
        let staminaNoteIcon = SpriteCreator(scene: scene, texture: "dollarNote", zPosition: 500, anchorPoints: nil, name: "dollarNoteActual")
        staminaNoteIcon.xScale = 0.15
        staminaNoteIcon.zPosition = 499
        staminaNoteIcon.yScale = dollarNoteIcon.xScale
        staminaNoteIcon.position = CGPoint(x: staminaIcon.frame.maxX + 10, y: staminaIcon.position.y)
        scene.addChild(staminaNoteIcon)
        
        //This is the stamina amount user has
        staminaAmountValue.zPosition = staminaNoteIcon.zPosition + 1
        staminaAmountValue.fontSize = 150
        staminaAmountValue.fontColor = .black
        staminaAmountValue.text = "x5"
        staminaAmountValue.position = CGPoint(x: staminaAmountValue.position.x, y: -45)
        staminaNoteIcon.addChild(staminaAmountValue)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
