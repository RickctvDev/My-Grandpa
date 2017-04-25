//
//  AudioMaker.swift
//  My Grandpa
//
//  Created by Rick Crane on 26/04/2017.
//  Copyright © 2017 Rick Crane. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

class AudioMaker{
    
    private var bgAudioPlayer = AVAudioPlayer()
    private var soundIsOn = true
    private var otherSoundIsOn = true
    
    init(){
        //https://youtu.be/gV9ts8IFMPQ This is the music for this game - we have to give credit
        
        do{
            bgAudioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "bgMusic", ofType: "mp3")!))
            bgAudioPlayer.prepareToPlay()
            bgAudioPlayer.volume = 0.1
            bgAudioPlayer.numberOfLoops = -1
            bgAudioPlayer.play()
        }
        catch{
            print(error)
        }
    }
    
    func playASound(scene : SKScene, fileNamed: String){
        
        if otherSoundIsOn == true{
            let soundToplay = SKAction.playSoundFileNamed(fileNamed, waitForCompletion: false)
            scene.run(soundToplay)
        }else{
            print("Sound File could not be played in SOUNDMANAGER, You could have swithced the sound off OR you need to enusre you have spelt the name of the sound correctly")
        }
    }
    
    func playAngryVoice(scene : SKScene){
        let voiceArray = ["angry1", "angry2", "angry3"]
        let random = Int(arc4random_uniform(UInt32(voiceArray.count)))
        let finalVoice = voiceArray[random]
        
        let playSound = SKAction.playSoundFileNamed(fileName: finalVoice, atVolume: 0.1, waitForCompletion: true)
        scene.run(playSound)
        
    }
    
    func playPainVoice(scene : SKScene){
        let voiceArray = ["pain1", "pain2", "pain3", "pain4"]
        let random = Int(arc4random_uniform(UInt32(voiceArray.count)))
        let finalVoice = voiceArray[random]
        
        let playSound = SKAction.playSoundFileNamed(fileName: finalVoice, atVolume: 0.1, waitForCompletion: true)
        scene.run(playSound)
    }
    
    
}

// reference: https://github.com/pepelkod/iOS-Examples/blob/master/PlaySoundWithVolume/PlaySoundWithVolumeAction.m

public extension SKAction {
    public class func playSoundFileNamed(fileName: String, atVolume: Float, waitForCompletion: Bool) -> SKAction {
        
        let soundPath = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        
        var player: AVAudioPlayer!
        do{
            player = try AVAudioPlayer(contentsOf: soundPath!)
            player.prepareToPlay()
            player.volume = atVolume
            player.numberOfLoops = 0
        }
        catch{
            print(error)
        }
        
        let playAction: SKAction = SKAction.run {
            player.play()
        }
        
        if(waitForCompletion){
            let waitAction = SKAction.wait(forDuration: player.duration)
            let groupAction: SKAction = SKAction.group([playAction, waitAction])
            return groupAction
        }
        
        return playAction
    }
}





