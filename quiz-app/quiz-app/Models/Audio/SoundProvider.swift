//
//  SoundsProvider.swift
//  quiz-app
//
//  Created by Elena Meneghini on 10/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import AudioToolbox

struct SoundProvider {
    let cheeringSound = Sound(soundName: "cheerCrowd", type: .mp3)
    let startGameSound = Sound(soundName: "gameSound", type: .wav)
    let roundCompleteSound = Sound(soundName: "roundCompleted", type: .wav)
    let correctSound = Sound(soundName: "soundCorrect", type: .wav)
    let wrongSound = Sound(soundName: "soundWrong", type: .wav)
    let timeOverSound = Sound(soundName: "timeOut", type: .wav)
}

