//
//  ViewController.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 01/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import UIKit
import AudioToolbox

// global properties
// let timeOverNotificationKey = "questionTimeOver"

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let gameManager = GameManager()
    let timer = questionTimer()
    var buttons = [UIButton]()
    
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    var cheeringSound: SystemSoundID = 0
    var timeOutSound: SystemSoundID = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionTracker: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func checkANswer(_ sender: UIButton) {
        // Disable all buttons
        for button in buttons {
            button.isEnabled = false
        }
        
        // Feedback message style
        questionField.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Button selected style
        sender.layer.borderColor = UIColor(red:0.00, green:0.83, blue:0.87, alpha:1.0).cgColor
        sender.layer.borderWidth = 2
        
        // Check the answer selected and display feedback
        if gameManager.isCorrect(sender.tag) {
            questionField.text = "Correct! 🎉"
            playCorrectSound()
            sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        } else {
            questionField.text = "Sorry, that's not it. 😬"
            
            // highlight wrong answer
            sender.layer.borderColor = UIColor(red:0.96, green:0.35, blue:0.57, alpha:1.0).cgColor
            
            // Highlight correct answer
            highlightCorrectQuestion()
        }
        
        // reset timer
        timer.reset()
        
        // call next round
        loadNextRound(delay: 2)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Reset game manager properties to 0
        gameManager.correctQuestions = 0
        gameManager.questionsAsked = 0
       
        // call next round
        nextRound()
        
        // play sound
        playGameStartSound()
    }
    
    // MARK: - Helpers
    
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
    
    func resetButtonsStyle() {
        option1Button.applyBasicStyle()
        option2Button.applyBasicStyle()
        option3Button.applyBasicStyle()
        option4Button.applyBasicStyle()
        
        questionField.font = UIFont.systemFont(ofSize: 18)
    }
    
    func hideAllButtons() {
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
    }
    
    func displayAnswers() {
        // Reset display without any button
        hideAllButtons()
        resetButtonsStyle()
        buttons = []
        
        // create buttons depending on number of answers of the selected question
        let questionSelected = gameManager.quiz.questions[gameManager.indexOfSelectedQuestion]
        let numOfAnswers = questionSelected.possibleAnswers.count
        
        switch numOfAnswers {
        case 1: buttons += [option1Button]
        case 2: buttons += [option1Button, option2Button]
        case 3: buttons += [option1Button, option2Button, option3Button]
        case 4: buttons += [option1Button, option2Button, option3Button, option4Button]
        default: print("This question has no answers")
        }
        
        for button in buttons {
            let index = button.tag
            button.setTitle(questionSelected.possibleAnswers[index], for: .normal)
            button.isHidden = false
            button.isEnabled = true
        }
    }
    
    func displayQuestion() {
        // Select random question
        let questionSelected = gameManager.getRandomQuestion()
        
        // Set labels text
        questionField.text = questionSelected.question
        questionTracker.text = "Question \(gameManager.questionsAsked) of \(gameManager.questionsPerRound)"
        
        // Display answers
        displayAnswers()
        
        // HIde play button
        playAgainButton.isHidden = true
        
        // Start timer
        timer.start()
        print(timer.secondsRemaining)
        
        // Progress bar
        progressBar.setProgress(timer.secondsRemaining, animated: true)
    }
    
    func highlightCorrectQuestion() {
        let correctAnswer = self.gameManager.quiz.questions[self.gameManager.indexOfSelectedQuestion].correctAnswer
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
            // Play sound
            self.playWrongSound()
            
            // Find the button with the correct answer
            for button in self.buttons {
                if button.tag == correctAnswer - 1 {
                    
                    // Correct answer button style
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                    button.layer.borderColor = UIColor(red: 0.3137, green: 0.8471, blue: 0.5451, alpha: 1.0).cgColor
                    button.layer.borderWidth = 2
                }
            }
        }
    }
    
    func displayScore() {
        hideAllButtons()
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsPerRound) correct!"
        
        if gameManager.correctQuestions == gameManager.questionsPerRound {
            playCheeringSound()
        }
    }
    
    func nextRound() {
        resetButtonsStyle()
        if gameManager.questionsAsked == gameManager.questionsPerRound {
            // Game is over
            displayScore()
            gameManager.previousQuestionIndexes = []
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    @objc func handleTimeOver(notification: NSNotification) {
        questionField.text = "Time Over! ⌛️"
        questionField.font = UIFont.boldSystemFont(ofSize: 20)
        highlightCorrectQuestion()
        
        // Time reset
        timer.reset()
        
        // call next round
        loadNextRound(delay: 3)
    }
    
    @objc func handleTimeReset(notification: NSNotification) {
        progressBar.setProgress(0, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameStartSound()
        loadWrongSound()
        loadCorrectSound()
        loadCheeringSound()
        loadTimeOutSound()
        playGameStartSound()
        
        displayQuestion()
        
        // Buttons styles
        playAgainButton.applyGradientStyle(colorOne: UIColor(red:0.00, green:0.87, blue:0.84, alpha:0.5), colorTwo: UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0))
        
        // Header style
        header.applyGradient(colorOne: UIColor(red:0.00, green:0.87, blue:0.84, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0))
        
        questionTracker.text = "Question \(gameManager.questionsAsked) of \(gameManager.questionsPerRound)"
    
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimeOver), name: Notification.Name(rawValue: "timeOver"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimeReset), name: Notification.Name(rawValue: "timeReset"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
 
