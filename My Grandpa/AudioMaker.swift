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
    
    init(){
    }
    
    func playBGMusic(){
        
        if soundIsOn == true {
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
                
        }else{
            print("Sound is set to false")
        }
    }
    
    func turnMusicOffOrOn(){
        if bgAudioPlayer.isPlaying{
            bgAudioPlayer.stop()
        }else{
            bgAudioPlayer.play()
        }
    }
    
    func bgMusicFadeOut(withSeconds : TimeInterval){
        bgAudioPlayer.setVolume(0, fadeDuration: withSeconds)
        
        _ = Timer.scheduledTimer(withTimeInterval: withSeconds, repeats: false) { (timer) in
            self.bgAudioPlayer.stop()
        }
    }
    
    func playButtonClickSound(scene : SKScene, atVolume : Float?){
        if otherSoundIsOn == true{
            let volumeToPass : Float!
            
            if atVolume == nil {
                //SET THIS VALUE FOR DEFAULT VAL FOR SOUND
                volumeToPass = 1
            }else{
                volumeToPass = atVolume
            }
            let soundToplay = SKAction.playSoundFileNamed(fileName: "buttonClick", atVolume: volumeToPass, waitForCompletion: true)
            scene.run(soundToplay)
        }else{
            print("Sound File could not be played in SOUNDMANAGER, You could have swithced the sound off OR you need to enusre you have spelt the name of the sound correctly")
        }
    }
    
    func playASound(scene : SKScene, fileNamed: String, atVolume : Float?){
        
        if otherSoundIsOn == true{
            let volumeToPass : Float!
            
            if atVolume == nil {
                //SET THIS VALUE FOR DEFAULT VAL FOR SOUND
                volumeToPass = 1
            }else{
                volumeToPass = atVolume
            }
            let soundToplay = SKAction.playSoundFileNamed(fileName: fileNamed, atVolume: volumeToPass, waitForCompletion: true)
            scene.run(soundToplay)
        }else{
            print("Sound File could not be played in SOUNDMANAGER, You could have swithced the sound off OR you need to enusre you have spelt the name of the sound correctly")
        }
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
