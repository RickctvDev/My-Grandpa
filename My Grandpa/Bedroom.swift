//
//  BedRoom
//  My Grandpa
//
//  Created by Rick Crane on 26/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import SpriteKit

class Bedroom {
    
    private var _floor : SKSpriteNode!
    private var _rightWall : SKShapeNode!
    private var _rightWallInner : SKShapeNode!
    private var _leftWall : SKShapeNode!
    private var _backWall : SKShapeNode!
    private var _roof : SKShapeNode!
    private var _roofBand : SKShapeNode!
    
    //Settings Here
    private var skirtingBoardColor = #colorLiteral(red: 0.2010116875, green: 0.3116192222, blue: 0.4158166647, alpha: 1)
    private var skirtingBoardSize : CGFloat = 5
    
    //Useful Variables:
    let backWallRoghtSideEndPoint : CGFloat = 140
    
    func createRoom(onScene : SKScene){
        createFloor(onScene: onScene)
        createLeftWall(onScene: onScene)
        createRightWall(onScene: onScene)
        createRightWallInner(onScene: onScene)
        createBackWall(onScene: onScene)
        createRoofBand(onScene: onScene)
        createRoof(onScene: onScene)
        
        //loadTexturesForHouse()
    }
    
    //LOAD TEXTURES IF YOU WANT THEM OR MAKE IT COLORS
    private func loadTexturesForHouse(){
        _floor.texture = SKTexture(imageNamed: "carpet5")
        _rightWallInner.fillTexture = SKTexture(imageNamed: "carpet5")
        _backWall.fillTexture = SKTexture(imageNamed: "wallpaper2")
        _rightWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        _leftWall.fillTexture = SKTexture(imageNamed: "wallpaper3")
        _roof.fillTexture = SKTexture(imageNamed: "roof1")
    }
    
    private func createFloor(onScene : SKScene){
        _floor = SKSpriteNode(color: .white, size: CGSize(width: onScene.frame.size.width, height: onScene.frame.size.height / 4))
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
    
    private func createLeftWall(onScene : SKScene){
        
        let cgPathLeftInGoingWall = CGMutablePath()
        cgPathLeftInGoingWall.move(to: CGPoint(x: _floor.frame.minX, y: onScene.frame.maxY))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x:cgPathLeftInGoingWall.currentPoint.x + 30, y: cgPathLeftInGoingWall.currentPoint.y))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x + 120, y: onScene.frame.maxY / 1.6))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: cgPathLeftInGoingWall.currentPoint.x, y: _floor.frame.maxY))
        cgPathLeftInGoingWall.addLine(to: CGPoint(x: onScene.frame.minX, y: _floor.frame.minY))
        cgPathLeftInGoingWall.closeSubpath()
        
        _leftWall = SKShapeNode(path: cgPathLeftInGoingWall)
        _leftWall.zPosition = 4
        _leftWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _leftWall.lineWidth = skirtingBoardSize
        _leftWall.fillColor = #colorLiteral(red: 0.4840993881, green: 0.6911504865, blue: 0.8696178794, alpha: 1)
        _leftWall.name = "Left Wall"
        onScene.addChild(_leftWall)
    }
    
    private func createRightWall(onScene : SKScene){
        
        let cgPathRightWall = CGMutablePath()
        cgPathRightWall.move(to: CGPoint(x: _floor.frame.maxX, y: _floor.frame.midY))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x - 140, y: cgPathRightWall.currentPoint.y))
        cgPathRightWall.addLine(to: CGPoint(x: cgPathRightWall.currentPoint.x, y: onScene.frame.maxY - 70))
        cgPathRightWall.addLine(to: CGPoint(x: onScene.frame.maxX, y: cgPathRightWall.currentPoint.y))
        cgPathRightWall.closeSubpath()
        
        _rightWall = SKShapeNode(path: cgPathRightWall)
        _rightWall.zPosition = _floor.zPosition + 3
        _rightWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _rightWall.lineWidth = skirtingBoardSize
        _rightWall.fillColor = #colorLiteral(red: 0.8448408842, green: 0.7535966039, blue: 0.7131484747, alpha: 1)
        _rightWall.name = "Right Wall"
        onScene.addChild(_rightWall)
    }
    
    private func createRightWallInner(onScene : SKScene){
        
        let cgPathRightWallInner = CGMutablePath()
        cgPathRightWallInner.move(to: CGPoint(x: _rightWall.frame.minX + 2, y: _rightWall.frame.minY + 2))
        cgPathRightWallInner.addLine(to: CGPoint(x: cgPathRightWallInner.currentPoint.x - 40, y: _floor.frame.maxY))
        cgPathRightWallInner.addLine(to: CGPoint(x: cgPathRightWallInner.currentPoint.x, y: _rightWall.frame.maxY - 20))
        cgPathRightWallInner.addLine(to: CGPoint(x: _rightWall.frame.minX, y: _rightWall.frame.maxY - 2))
        cgPathRightWallInner.closeSubpath()
        
        _rightWallInner = SKShapeNode(path: cgPathRightWallInner)
        _rightWallInner.zPosition = _rightWall.zPosition - 1
        _rightWallInner.fillColor = #colorLiteral(red: 0.8448408842, green: 0.7535966039, blue: 0.7131484747, alpha: 1)
        _rightWallInner.strokeColor = skirtingBoardColor // is the skirtingboard color
        _rightWallInner.lineWidth = skirtingBoardSize
        _rightWallInner.name = "Right Wall Inner Frame"
        onScene.addChild(_rightWallInner)
    }
    
    private func createBackWall(onScene : SKScene){
        let cgPathBackWall = CGMutablePath()
        cgPathBackWall.move(to: CGPoint(x: _rightWall.frame.minX, y: _floor.frame.maxY))
        cgPathBackWall.addLine(to: CGPoint(x: _leftWall.frame.maxX, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.addLine(to: CGPoint(x: cgPathBackWall.currentPoint.x, y: _rightWallInner.frame.maxY - 20))
        cgPathBackWall.addLine(to: CGPoint(x: _rightWallInner.frame.minX + 2, y: cgPathBackWall.currentPoint.y))
        cgPathBackWall.closeSubpath()
        
        _backWall = SKShapeNode(path: cgPathBackWall)
        _backWall.zPosition = _rightWallInner.zPosition - 1
        _backWall.strokeColor = skirtingBoardColor // is the skirtingboard color
        _backWall.lineWidth = skirtingBoardSize
        _backWall.fillColor = #colorLiteral(red: 0.8448408842, green: 0.7535966039, blue: 0.7131484747, alpha: 1)
        _backWall.name = "Back Wall"
        onScene.addChild(_backWall)
    }
    
    
    
    private func createRoofBand(onScene:SKScene){
        let cgPathRoofBand = CGMutablePath()
        cgPathRoofBand.move(to: CGPoint(x: _backWall.frame.minX, y: _backWall.frame.maxY)) // bottom left
        cgPathRoofBand.addLine(to: CGPoint(x: cgPathRoofBand.currentPoint.x - 13, y: onScene.frame.maxY / 1.6 + 7)) // up to top left
        cgPathRoofBand.addLine(to: CGPoint(x: _rightWallInner.frame.minX - 15, y: cgPathRoofBand.currentPoint.y)) // over to far right
        cgPathRoofBand.addLine(to: CGPoint(x: cgPathRoofBand.currentPoint.x + 80, y: onScene.frame.maxY)) // up to max height
        cgPathRoofBand.addLine(to: CGPoint(x: cgPathRoofBand.currentPoint.x + 40, y: onScene.frame.maxY)) // slight over to right
        cgPathRoofBand.addLine(to: CGPoint(x: _rightWallInner.frame.minX - 10, y: _backWall.frame.maxY)) // to top of right inner wall
        
        cgPathRoofBand.closeSubpath()
        
        _roofBand = SKShapeNode(path: cgPathRoofBand)
        _roofBand.zPosition = _leftWall.zPosition + 1
        _roofBand.strokeColor = skirtingBoardColor // is the skirtingboard color
        _roofBand.lineWidth = skirtingBoardSize - 2
        _roofBand.fillColor = #colorLiteral(red: 0.9926175475, green: 0.9803953767, blue: 0.8096949458, alpha: 1)
        _roofBand.name = "Roof Band"
        onScene.addChild(_roofBand)
        
    }
    
    private func createRoof(onScene : SKScene){
        let cgPathRoof = CGMutablePath()
        cgPathRoof.move(to: CGPoint(x: onScene.frame.midX, y: onScene.frame.midY))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.maxX, y: cgPathRoof.currentPoint.y))
        cgPathRoof.addLine(to: CGPoint(x: cgPathRoof.currentPoint.x, y: onScene.frame.maxY))
        cgPathRoof.addLine(to: CGPoint(x: onScene.frame.minX, y: cgPathRoof.currentPoint.y))
        cgPathRoof.closeSubpath()
        
        _roof = SKShapeNode(path: cgPathRoof)
        _roof.zPosition = _rightWall.zPosition - 3
        _roof.strokeColor = skirtingBoardColor // is the skirtingboard color
        _roof.lineWidth = skirtingBoardSize
        _roof.fillColor = #colorLiteral(red: 0.8519027829, green: 0.7891942859, blue: 0.7885763645, alpha: 1)
        _roof.name = "roof"
        onScene.addChild(_roof)
    }
}

