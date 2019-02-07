//
//  SoundPlayer.swift
//  quiz-app
//
//  Created by Elena Meneghini on 10/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import AudioToolbox

class SoundPlayer {
    let soundProvider = SoundProvider()
    
    func play(_ sound: Sound) {
        let soundUrl = sound.soundURL as CFURL
        var mySound: SystemSoundID = 0 // This property stores the sound we want to play
        AudioServicesCreateSystemSoundID(soundUrl, &mySound)
        AudioServicesPlaySystemSound(mySound)
    }
}

