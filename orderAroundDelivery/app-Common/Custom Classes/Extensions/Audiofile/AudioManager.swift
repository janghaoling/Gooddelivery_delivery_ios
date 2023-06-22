//
//  AudioManager.swift
//  GoJekProvider
//
//  Created by Rajes on 22/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    
    static var share = AudioManager()
    
    var alertPlayer: AVAudioPlayer?
    
    func startPlay() {
        
        let path = Bundle.main.path(forResource: "alert_tone.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            alertPlayer = try AVAudioPlayer(contentsOf: url)
            alertPlayer?.numberOfLoops = -1
            alertPlayer?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func stopSound() {
        
        if let _ = alertPlayer{
            alertPlayer?.stop()
        }
    }
}
