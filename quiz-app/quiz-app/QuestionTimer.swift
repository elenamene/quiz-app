//
//  questionTimer.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 06/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import Foundation

class questionTimer {
    var timer = Timer()
    var secondsPerQuestion: Float = 15
    var timerIsOn = false
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        timerIsOn = true
        print("time started")
    }
    
    @objc func updateCounter() {
        secondsPerQuestion -= 1
        print(secondsPerQuestion)
        if secondsPerQuestion == 0 {
            timer.invalidate()
            print("time over")
        }
    }
    
    func reset() {
        secondsPerQuestion = 15
        timer.invalidate()
        timerIsOn = false
        print("time stopped")
    }
}
