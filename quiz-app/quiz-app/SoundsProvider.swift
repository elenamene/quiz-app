//
//  SoundsProvider.swift
//  quiz-app
//
//  Created by Elena Meneghini on 08/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import AudioToolbox

enum Sound {
    case startGame
    case correct
    case wrong
    case timeOver
    case cheering
}

struct SoundsProvider {
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    var cheeringSound: SystemSoundID = 0
    var timeOutSound: SystemSoundID = 0
    
    mutating func loadSounds(_ sound: Sound) {
        switch sound {
        case .startGame:
            let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
            let soundUrl = URL(fileURLWithPath: path!)
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        case .correct:
            let path = Bundle.main.path(forResource: "soundCorrect", ofType: "wav")
            let soundUrl = URL(fileURLWithPath: path!)
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &correctSound)
        case .wrong:
            let path = Bundle.main.path(forResource: "soundWrong", ofType: "wav")
            let soundUrl = URL(fileURLWithPath: path!)
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &wrongSound)
        case .timeOver:
            let path = Bundle.main.path(forResource: "timeOut", ofType: "wav")
            let soundUrl = URL(fileURLWithPath: path!)
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &timeOutSound)
        case .cheering:
            let path = Bundle.main.path(forResource: "cheerCrowd", ofType: "mp3")
            let soundUrl = URL(fileURLWithPath: path!)
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &cheeringSound)
        }
    }
    
    func playSound(_ sound: Sound) {
        switch sound {
        case.startGame: return  AudioServicesPlaySystemSound(gameSound)
        case.correct: return  AudioServicesPlaySystemSound(correctSound)
        case.wrong: return  AudioServicesPlaySystemSound(wrongSound)
        case.timeOver: return  AudioServicesPlaySystemSound(timeOutSound)
        case.cheering: return  AudioServicesPlaySystemSound(cheeringSound)
            
        }
    }
}

/*
func loadGameStartSound() {
    let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
}


func playGameStartSound() {
    AudioServicesPlaySystemSound(gameSound)
}


func loadCorrectSound() {
    let path = Bundle.main.path(forResource: "soundCorrect", ofType: "wav")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &correctSound)
}

func playCorrectSound() {
    AudioServicesPlaySystemSound(correctSound)
}

func loadWrongSound() {
    let path = Bundle.main.path(forResource: "soundWrong", ofType: "wav")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &wrongSound)
}

func playWrongSound() {
    AudioServicesPlaySystemSound(wrongSound)
}

func loadCheeringSound() {
    let path = Bundle.main.path(forResource: "cheerCrowd", ofType: "mp3")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &cheeringSound)
}

func playCheeringSound() {
    AudioServicesPlaySystemSound(cheeringSound)
}

func loadTimeOutSound() {
    let path = Bundle.main.path(forResource: "timeOut", ofType: "wav")
    let soundUrl = URL(fileURLWithPath: path!)
    AudioServicesCreateSystemSoundID(soundUrl as CFURL, &timeOutSound)
}

func playTimeOutSound() {
    AudioServicesPlaySystemSound(timeOutSound)
}
*/
