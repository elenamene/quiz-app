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
    var secondsRemaining: Float = 15
    var isOn = false
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        isOn = true
        print("time started")
    }
    
    @objc func updateCounter() {
        secondsRemaining -= 1
        print(secondsRemaining)
        if secondsRemaining == 0 {
            timer.invalidate()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "timeOver"), object: nil)
        }
    }
    
    func reset() {
        secondsRemaining = 15
        timer.invalidate()
        isOn = false
        print("time stopped")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "timeReset"), object: nil)
    }
}
