//
//  Sound.swift
//  quiz-app
//
//  Created by Elena Meneghini on 10/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation
import AudioToolbox

enum SoundType: String {
    case mp3
    case wav
}

struct Sound {
    let soundName: String
    let type: SoundType
    var soundURL: URL {
        let path = Bundle.main.path(forResource: soundName, ofType: type.rawValue)
        return URL(fileURLWithPath: path!)
    }
}
