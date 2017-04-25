//
//  LivingRoom.swift
//  My Grandpa
//
//  Created by Rick Crane on 26/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class LivingRoom {
    private var _floor : SKSpriteNode!
    private var _rightWall : SKShapeNode!
    private var _leftWall : SKShapeNode!
    private var _leftInGoingWall : SKShapeNode!
    private var _backWall : SKShapeNode!
    private var _roof : SKShapeNode!
    private var _door : SKShapeNode!
    
    private var rightWallFarLeftHeight : CGFloat!
    private let rightWallWidth : CGFloat = 80
    
    //Settings Here
    private var skirtingBoardColor = UIColor.brown
    private var skirtingBoardSize : CGFloat = 5
    
    var floor: SKTexture{
        get {
            return _floor.texture!
        }
        set{
            //_floor.texture = newValue
            
            print("recieved \(newValue)")
        }
    }
    
    var rightWall: SKTexture{
        get {
            return _rightWall.fillTexture!
        }
        set{
            _rightWall.fillTexture = newValue
        }
    }
    
    var leftWall: SKTexture{
        get {
            return _leftWall.fillTexture!
        }
        set{
            _leftWall.fillTexture = newValue
        }
    }
    
    var leftInGoingWall: SKTexture{
        get {
            return _leftInGoingWall.fillTexture!
        }
        set{
            _leftInGoingWall.fillTexture = newValue
        }
    }
    
    var backWall: SKTexture{
        get {
            return _backWall.fillTexture!
        }
        set{
            _backWall.fillTexture = newValue
        }
    }
    
    var roof: SKTexture{
        get {
            return _roof.fillTexture!
        }
        set{
            _roof.fillTexture = newValue
        }
    }
    
    var door: SKTexture{
        get {
            return _door.fillTexture!
        }
        set{
            _door.fillTexture = newValue
        }
    }
    
    init(){
        
    }
    
    private func loadTexturesForHouse(){
        _door.fillTexture = SKTexture(imageNamed: "door2")
        _floor.texture = SKTexture(imageNamed: "floor3")
        _rightWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        _leftWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        _backWall.fillTexture = SKTexture(imageNamed: "wallpaper2")
        _leftInGoingWall.fillTexture = SKTexture(imageNamed: "wallpaper2")
        _roof.fillTexture = SKTexture(imageNamed: "roof1")
    }
    
    func createLivingRoom(onScene : SKScene){
        createFloor(onScene: onScene)
        createRightWall(onScene: onScene)
        createLeftWall(onScene: onScene)
        createLeftInGoingWall(onScene: onScene)
        createRoof(onScene: onScene)
        createBackWall(onScene: onScene)
        createDoor(onScene: onScene)
        loadTexturesForHouse()
    }
    
    private func createFloor(onScene : SKScene){
        _floor = SKSpriteNode(color: .white, size: CGSize(width: onScene.frame.size.width, height: onScene.frame.size.height / 5))
        _floor.anchorPoint = CGPoint(x: 0.5, y: 0)
        _floor.position = CGPoint(x: onScene.frame.midX, y: onScene.frame.minY)
        _floor.texture = SKTexture(imageNamed: "floor3")
        _floor.name = "floor"
        onScene.addChild(_floor)
        
        let floorSkirtingBoard = SKSpriteNode(color: skirtingBoardColor, size: CGSize(width: _floor.size.width, height: skirtingBoardSize))
        floorSkirtingBoard.anchorPoint = _floor.anchorPoint
        floorSkirtingBoard.position = CGPoint(x: _floor.frame.midX, y: _floor.frame.maxY - floorSkirtingBoard.frame.size.height)
        floorSkirtingBoard.zPosition = _floor.zPosition + 1
        onScene.addChild(floorSkirtingBoard)
    }
    
    private func createRightWall(onScene : SKScene){
        rightWallFarLeftHeight = onScene.frame.maxY - 40
        
        let cgPathRightWall = CGMutablePath()
        cgPathRightWall.move(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.minY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x - rightWallWidth, y: _floor.frame.maxY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathRightWall.addLine(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.maxY))
        cgPathRightWall.closeSubpath()
        
        _rightWall = SKShapeNode(path: cgPathRightWall)
        _rightWall.zPosition = _floor.zPosition + 1
        _rightWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _rightWall.lineWidth = skirtingBoardSize
        _rightWall.fillColor = .white
        _rightWall.name = "Right Wall"
        onScene.addChild(_rightWall)
    }
    
    private func createLeftWall(onScene : SKScene){
        let leftWallWidth : CGFloat = 140
        let leftWallHeight : CGFloat = 30
        
        let finalXPosLeftWall : CGFloat = onScene.frame.minX - 5
        let cgPathLeftWall = CGMutablePath()
        cgPathLeftWall.move(to: CGPoint(x: finalXPosLeftWall, y: onScene.frame.maxY - 2))
        cgPathLeftWall.addLine(to: CGPoint(x: cgPathLeftWall.currentPoint.x + leftWallWidth, y: cgPathLeftWall.currentPoint.y))
        cgPathLeftWall.addLine(to: CGPoint(x: cgPathLeftWall.currentPoint.x, y: _floor.frame.maxY - leftWallHeight))
        cgPathLeftWall.addLine(to: CGPoint(x: finalXPosLeftWall, y: cgPathLeftWall.currentPoint.y))
        cgPathLeftWall.closeSubpath()
        
        _leftWall = SKShapeNode(path: cgPathLeftWall)
        _leftWall.zPosition = _rightWall.zPosition
        _leftWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _leftWall.lineWidth = skirtingBoardSize
        _leftWall.fillColor = .white
        _leftWall.name = "Left Wall"
        onScene.addChild(_leftWall)
    }
    
    private func createLeftInGoingWall(onScene : SKScene){
        let leftInFinalXPos = _leftWall.frame.maxX - 2
        let leftInGoingWallWidth : CGFloat = 20
        
        let cgPathLeftInGoingWall = CGMutablePath()
        cgPathLeftInGoingWall.move(to: CGPoint(x: leftInFinalXPos, y: _leftWall.frame.minY + 2))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x + leftInGoingWallWidth, y: _floor.frame.maxY))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: leftInFinalXPos, y: _leftWall.frame.maxY))
        cgPathLeftInGoingWall.closeSubpath()
        
        _leftInGoingWall = SKShapeNode(path: cgPathLeftInGoingWall)
        _leftInGoingWall.zPosition = _rightWall.zPosition
        _leftInGoingWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _leftInGoingWall.lineWidth = skirtingBoardSize
        _leftInGoingWall.fillColor = .white
        _leftInGoingWall.name = "Inner Left Wall"
        onScene.addChild(_leftInGoingWall)
    }
    
    private func createRoof(onScene : SKScene){
        let cgPathRoof = CGMutablePath()
        cgPathRoof.move(to: CGPoint(x: _leftInGoingWall.frame.maxX, y: rightWallFarLeftHeight))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.maxX - rightWallWidth, y: cgPathRoof.currentPoint.y))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.maxY + 2))
        cgPathRoof.addLine(to: CGPoint(x: _leftWall.frame.maxX, y: cgPathRoof.currentPoint.y))
        cgPathRoof.closeSubpath()
        
        _roof = SKShapeNode(path: cgPathRoof)
        _roof.zPosition = _rightWall.zPosition
        _roof.strokeColor = skirtingBoardColor // is the skirtingboard color
        _roof.lineWidth = skirtingBoardSize
        _roof.fillColor = .white
        _roof.name = "roof"
        onScene.addChild(_roof)
    }
    
    private func createBackWall(onScene : SKScene){
        let cgPathBackWall = CGMutablePath()
        cgPathBackWall.move(to: CGPoint(x: _leftInGoingWall.frame.maxX, y: _floor.frame.maxY))
        cgPathBackWall.addLine(to: CGPoint(x: _rightWall.frame.minX, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.addLine(to: CGPoint(x: cgPathBackWall.currentPoint.x, y: rightWallFarLeftHeight))
        cgPathBackWall.addLine(to: CGPoint(x: _leftInGoingWall.frame.maxX, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.closeSubpath()
        
        _backWall = SKShapeNode(path: cgPathBackWall)
        _backWall.zPosition = _rightWall.zPosition - 2
        _backWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _backWall.lineWidth = skirtingBoardSize
        _backWall.fillColor = .white
        _backWall.name = "Back Wall"
        onScene.addChild(_backWall)
    }
    
    private func createDoor(onScene : SKScene){
        let doorPosFromLeft : CGFloat = 23
        let doorWidth : CGFloat = _backWall.frame.size.width / 4
        let doorHeight : CGFloat = _backWall.frame.size.height / 10
        let finalDoorXPos : CGFloat = _leftInGoingWall.frame.maxX + doorPosFromLeft
        
        let cgPathDoor = CGMutablePath()
        cgPathDoor.move(to: CGPoint(x: finalDoorXPos, y: _floor.frame.maxY - 4))
        cgPathDoor.addLine(to: CGPoint(x: cgPathDoor.currentPoint.x + doorWidth, y: cgPathDoor.currentPoint.y))
        cgPathDoor.addLine(to: CGPoint(x: cgPathDoor.currentPoint.x, y: _backWall.frame.midY + doorHeight))
        cgPathDoor.addLine(to: CGPoint(x: finalDoorXPos, y: cgPathDoor.currentPoint.y))
        cgPathDoor.closeSubpath()
        
        _door = SKShapeNode(path: cgPathDoor)
        _door.zPosition = _backWall.zPosition + 1
        _door.strokeColor = skirtingBoardColor
        _door.lineWidth = 0
        _door.fillColor = .white
        _door.name = "door"
        onScene.addChild(_door)
    }
}
