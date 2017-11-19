//
//  LivingRoom.swift
//  My Grandpa
//
//  Created by Rick Crane on 26/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class Bathroom {

    private var _floor : SKSpriteNode!
    private var _rightWall : SKShapeNode!
    private var _rightWallTilesFrame : SKShapeNode!
    private var _rightWallTop : SKShapeNode!
    private var _leftWall : SKShapeNode!
    private var _leftWallTilesFrame : SKShapeNode!
    private var _leftWallTop : SKShapeNode!
    private var _backWall : SKShapeNode!
    private var _backWallTilesFrame : SKShapeNode!
    private var _backWallTop : SKShapeNode!
    private var _roof : SKShapeNode!
    
    //Settings Here
    private var skirtingBoardColor = #colorLiteral(red: 0.2010116875, green: 0.3116192222, blue: 0.4158166647, alpha: 1)
    private var skirtingBoardSize : CGFloat = 5
    
    //Useful Variables:
    let backWallRoghtSideEndPoint : CGFloat = 140
    
    var floor: SKTexture{
        get {
            return _floor.texture!
        }
        set{
            _floor.texture = newValue
            print("recieved \(newValue)")
        }
    }
    
    func createRoom(onScene : SKScene){
        createFloor(onScene: onScene)
        createRightWall(onScene: onScene)
        createLeftWall(onScene: onScene)
        createRoof(onScene: onScene)
        createBackWall(onScene: onScene)
        createTiles(onScene: onScene)
        loadTexturesForHouse()
    }
    
    //LOAD TEXTURES IF YOU WANT THEM OR MAKE IT COLORS
    private func loadTexturesForHouse(){
        _floor.texture = SKTexture(imageNamed: "carpet5")
        _backWallTilesFrame.fillTexture = SKTexture(imageNamed: "bathroomWallpaper")
        _leftWallTilesFrame.fillTexture = SKTexture(imageNamed: "carpet5")
        _rightWallTilesFrame.fillTexture = SKTexture(imageNamed: "carpet5")
        
        //_rightWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        //_leftWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        //_backWall.fillTexture = SKTexture(imageNamed: "wallpaper2")
        //_roof.fillTexture = SKTexture(imageNamed: "roof1")
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
        
        let cgPathRightWall = CGMutablePath()
        cgPathRightWall.move(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.minY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x - 100, y: _floor.frame.maxY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x, y: onScene.frame.maxY - 70))
        cgPathRightWall.addLine(to: CGPoint(x: onScene.frame.maxX, y: onScene.frame.maxY))
        cgPathRightWall.closeSubpath()
        
        _rightWall = SKShapeNode(path: cgPathRightWall)
        _rightWall.zPosition = _floor.zPosition + 3
        _rightWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _rightWall.lineWidth = skirtingBoardSize
        _rightWall.fillColor = #colorLiteral(red: 0.4840993881, green: 0.6911504865, blue: 0.8696178794, alpha: 1)
        _rightWall.name = "Right Wall"
        onScene.addChild(_rightWall)
    }
    
    private func createLeftWall(onScene : SKScene){
        
        let cgPathLeftInGoingWall = CGMutablePath()
        cgPathLeftInGoingWall.move(to: CGPoint(x: onScene.frame.minX, y: onScene.frame.minY))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x + 90, y: _floor.frame.maxY))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x, y: onScene.frame.maxY - 80))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: onScene.frame.minX, y: onScene.frame.maxY))
        cgPathLeftInGoingWall.closeSubpath()
        
        _leftWall = SKShapeNode(path: cgPathLeftInGoingWall)
        _leftWall.zPosition = _rightWall.zPosition
        _leftWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _leftWall.lineWidth = skirtingBoardSize
        _leftWall.fillColor = #colorLiteral(red: 0.4840993881, green: 0.6911504865, blue: 0.8696178794, alpha: 1)
        _leftWall.name = "Left Wall"
        onScene.addChild(_leftWall)
    }
    
    private func createRoof(onScene : SKScene){
        let cgPathRoof = CGMutablePath()
        cgPathRoof.move(to: CGPoint(x: onScene.frame.minX, y: onScene.frame.minY))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.maxX, y: cgPathRoof.currentPoint.y))
        cgPathRoof.addLine(to: CGPoint(x: cgPathRoof.currentPoint.x, y: onScene.frame.maxY))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.minX, y: cgPathRoof.currentPoint.y))
        cgPathRoof.closeSubpath()
        
        _roof = SKShapeNode(path: cgPathRoof)
        _roof.zPosition = _rightWall.zPosition - 3
        _roof.strokeColor = skirtingBoardColor // is the skirtingboard color
        _roof.lineWidth = skirtingBoardSize
        _roof.fillColor = #colorLiteral(red: 0.9996390939, green: 1, blue: 0.9997561574, alpha: 1)
        _roof.name = "roof"
        onScene.addChild(_roof)
    }
    
    private func createBackWall(onScene : SKScene){
        let cgPathBackWall = CGMutablePath()
        cgPathBackWall.move(to: CGPoint(x: _leftWall.frame.maxX - 30, y: _floor.frame.maxY))
        cgPathBackWall.addLine(to: CGPoint(x: cgPathBackWall.currentPoint.x, y: _leftWall.frame.maxY - 40))
        cgPathBackWall.addLine(to: CGPoint(x: _rightWall.frame.maxX + 10, y: _rightWall.frame.maxY - backWallRoghtSideEndPoint))
        cgPathBackWall.addLine(to: CGPoint(x: cgPathBackWall.currentPoint.x, y: _floor.frame.maxY))
        cgPathBackWall.closeSubpath()
        
        _backWall = SKShapeNode(path: cgPathBackWall)
        _backWall.zPosition = _rightWall.zPosition - 2
        _backWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _backWall.lineWidth = skirtingBoardSize
        _backWall.fillColor = #colorLiteral(red: 0.4840993881, green: 0.6911504865, blue: 0.8696178794, alpha: 1)
        _backWall.name = "Back Wall"
        onScene.addChild(_backWall)
    }
    
    
    private func createTiles(onScene : SKScene){
        createBackWallTiles(onScene: onScene)
        createLeftWallTiles(onScene: onScene)
        createRightWallTiles(onScene: onScene)
        createBackWallTop(onScene: onScene)
        createRightWallTop(onScene: onScene)
        createLeftWallTop(onScene: onScene)
    }
    
    private func createBackWallTiles(onScene : SKScene){
        
        let cgPathBackWallTiles = CGMutablePath()
        cgPathBackWallTiles.move(to: CGPoint(x: _leftWall.frame.maxX, y: _backWall.frame.minY + 5))
        cgPathBackWallTiles.addLine(to: CGPoint(x: cgPathBackWallTiles.currentPoint.x, y: _backWall.frame.midY + 20))
        cgPathBackWallTiles.addLine(to: CGPoint(x: _rightWall.frame.minX, y: cgPathBackWallTiles.currentPoint.y - 40)) //over on the right hand side
        
        cgPathBackWallTiles.addLine(to: CGPoint(x: cgPathBackWallTiles.currentPoint.x, y: _backWall.frame.minY + 5))
        cgPathBackWallTiles.closeSubpath()
        
        _backWallTilesFrame = SKShapeNode(path: cgPathBackWallTiles)
        _backWallTilesFrame.zPosition = _backWall.zPosition + 1
        _backWallTilesFrame.fillColor = .white
        _backWallTilesFrame.strokeColor = .white // is the skirtingboard color
        _backWallTilesFrame.lineWidth = 1.5
        _backWallTilesFrame.name = "Back Wall Tiles Frame"
        onScene.addChild(_backWallTilesFrame)
    }
    
    private func createLeftWallTiles(onScene : SKScene){
        
        let cgPathLeftWallTiles = CGMutablePath()
        cgPathLeftWallTiles.move(to: CGPoint(x: _leftWall.frame.minX + 7, y: _leftWall.frame.midY + 50))
        cgPathLeftWallTiles.addLine(to: CGPoint(x: _leftWall.frame.maxX - 6, y: cgPathLeftWallTiles.currentPoint.y - 30))
        cgPathLeftWallTiles.addLine(to: CGPoint(x: cgPathLeftWallTiles.currentPoint.x, y: _floor.frame.maxY)) //over on the right hand side
        
        cgPathLeftWallTiles.addLine(to: CGPoint(x: _leftWall.frame.minX + 7, y: _leftWall.frame.minY + 7))
        cgPathLeftWallTiles.closeSubpath()
        
        _leftWallTilesFrame = SKShapeNode(path: cgPathLeftWallTiles)
        _leftWallTilesFrame.zPosition = _leftWall.zPosition + 1
        _leftWallTilesFrame.fillColor = .white
        _leftWallTilesFrame.strokeColor = skirtingBoardColor // is the skirtingboard color
        _leftWallTilesFrame.lineWidth = 2
        _leftWallTilesFrame.name = "Left Wall Tiles Frame"
        onScene.addChild(_leftWallTilesFrame)
    }
    
    private func createRightWallTiles(onScene : SKScene){
        
        let cgPathRightWallTiles = CGMutablePath()
        cgPathRightWallTiles.move(to: CGPoint(x: _rightWall.frame.maxX - 7, y: _rightWall.frame.midY + 60))
        cgPathRightWallTiles.addLine(to: CGPoint(x: _rightWall.frame.minX + 6, y: cgPathRightWallTiles.currentPoint.y - 40))
        cgPathRightWallTiles.addLine(to: CGPoint(x: cgPathRightWallTiles.currentPoint.x, y: _floor.frame.maxY)) //over on the right hand side
        
        cgPathRightWallTiles.addLine(to: CGPoint(x: _rightWall.frame.maxX - 7, y: _floor.frame.minY + 7))
        cgPathRightWallTiles.closeSubpath()
        
        _rightWallTilesFrame = SKShapeNode(path: cgPathRightWallTiles)
        _rightWallTilesFrame.zPosition = _rightWall.zPosition + 1
        _rightWallTilesFrame.fillColor = .white
        _rightWallTilesFrame.strokeColor = skirtingBoardColor // is the skirtingboard color
        _rightWallTilesFrame.lineWidth = 2
        _rightWallTilesFrame.name = "Right Wall Tiles Frame"
        onScene.addChild(_rightWallTilesFrame)
    }
    
    private func createBackWallTop(onScene: SKScene){
        let cgPathBackWallTop = CGMutablePath()
        cgPathBackWallTop.move(to: CGPoint(x: _backWall.frame.minX + 1.4, y: _backWall.frame.maxY - 1))
        cgPathBackWallTop.addLine(to: CGPoint(x: cgPathBackWallTop.currentPoint.x, y: cgPathBackWallTop.currentPoint.y - 15))
        cgPathBackWallTop.addLine(to: CGPoint(x: _rightWall.frame.minX + 2, y: cgPathBackWallTop.currentPoint.y - backWallRoghtSideEndPoint / 2))
        cgPathBackWallTop.addLine(to: CGPoint(x: cgPathBackWallTop.currentPoint.x, y: cgPathBackWallTop.currentPoint.y + 15))
        cgPathBackWallTop.closeSubpath()
        
        _backWallTop = SKShapeNode(path: cgPathBackWallTop)
        _backWallTop.zPosition = _backWall.zPosition + 1
        _backWallTop.fillColor = .white
        _backWallTop.strokeColor = skirtingBoardColor // is the skirtingboard color
        _backWallTop.lineWidth = 1.4
        _backWallTop.name = "Back Wall Top"
        _backWall.addChild(_backWallTop)
    }
    
    private func createRightWallTop(onScene: SKScene){
        let cgPathRightWallTop = CGMutablePath()
        cgPathRightWallTop.move(to: CGPoint(x: _rightWall.frame.maxX, y: onScene.frame.maxY + 4))
        cgPathRightWallTop.addLine(to: CGPoint(x: cgPathRightWallTop.currentPoint.x, y: cgPathRightWallTop.currentPoint.y - 15))
        cgPathRightWallTop.addLine(to: CGPoint(x: _rightWall.frame.minX + 2,
                                               y: cgPathRightWallTop.currentPoint.y - backWallRoghtSideEndPoint / 2))
        cgPathRightWallTop.addLine(to: CGPoint(x: cgPathRightWallTop.currentPoint.x, y: cgPathRightWallTop.currentPoint.y + 15))
        cgPathRightWallTop.closeSubpath()
        
        _rightWallTop = SKShapeNode(path: cgPathRightWallTop)
        _rightWallTop.zPosition = _rightWall.zPosition + 1
        _rightWallTop.fillColor = .white
        _rightWallTop.strokeColor = skirtingBoardColor // is the skirtingboard color
        _rightWallTop.lineWidth = 1.4
        _rightWallTop.name = "Right Wall Top"
        _rightWall.addChild(_rightWallTop)
    }
    
    private func createLeftWallTop(onScene: SKScene){
        let cgPathLeftWallTop = CGMutablePath()
        cgPathLeftWallTop.move(to: CGPoint(x: _leftWall.frame.minX + 1.4, y: onScene.frame.maxY + 4))
        cgPathLeftWallTop.addLine(to: CGPoint(x: _leftWall.frame.maxX, y: onScene.frame.maxY - 80))
        cgPathLeftWallTop.addLine(to: CGPoint(x: cgPathLeftWallTop.currentPoint.x,
                                               y: cgPathLeftWallTop.currentPoint.y - 15))
        cgPathLeftWallTop.addLine(to: CGPoint(x: _leftWall.frame.minX, y: onScene.frame.maxY - 15))
        cgPathLeftWallTop.closeSubpath()
        
        _leftWallTop = SKShapeNode(path: cgPathLeftWallTop)
        _leftWallTop.zPosition = _leftWall.zPosition + 1
        _leftWallTop.fillColor = .white
        _leftWallTop.strokeColor = skirtingBoardColor // is the skirtingboard color
        _leftWallTop.lineWidth = 1.4
        _leftWallTop.name = "Left Wall Top"
        _leftWall.addChild(_leftWallTop)
    }
    
}
