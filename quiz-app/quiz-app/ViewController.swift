//
//  ViewController.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 01/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var confetti: UIImageView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionTracker: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    @IBOutlet weak var option4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    // MARK: - Properties
    
    let gameManager = GameManager()
    let timer = QuestionTimer()
    let soundPlayer = SoundPlayer()
    var buttons = [UIButton]()
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Disable all buttons
        disableAllButtons()
        
        // Styles
        questionField.font = UIFont.boldSystemFont(ofSize: 20)
        sender.layer.borderColor = UIColor(red:0.00, green:0.83, blue:0.87, alpha:1.0).cgColor
        sender.layer.borderWidth = 2
        
        // Check if the answer is correct and display feedback
        if gameManager.isCorrect(sender.tag) {
            questionField.text = "Correct! 🎉"
            soundPlayer.play(soundPlayer.soundProvider.correctSound)
            sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        } else {
            questionField.text = "Sorry, that's not it. 😬"
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
        // Reset game manager properties
        gameManager.correctQuestions = 0
        gameManager.questionsAsked = 0
       
        // call next round
        nextRound()
        
        // Change background
        grayView.backgroundColor = UIColor(red:0.96, green:0.97, blue:0.98, alpha:1.0)
        
        // play sound
        soundPlayer.play(soundPlayer.soundProvider.startGameSound)
    }
    
    // MARK: - Helpers

    // Buttons
    
    func resetButtonsStyle() {
        option1Button.applyBasicStyle()
        option2Button.applyBasicStyle()
        option3Button.applyBasicStyle()
        option4Button.applyBasicStyle()
        playAgainButton.applyBasicStyle()
        playAgainButton.setTitleColor(UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0), for: .normal)
        playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        questionField.font = UIFont.systemFont(ofSize: 18)
    }
    
    func hideAllButtons() {
        option1Button.isHidden = true
        option2Button.isHidden = true
        option3Button.isHidden = true
        option4Button.isHidden = true
    }
    
    func disableAllButtons() {
        for button in buttons {
            button.isEnabled = false
        }
    }
    
    // Quiz
    
    func displayAnswers() {
        
        // Reset display without any buttons
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
        
        // Hide final score image
        confetti.isHidden = true
        
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
            self.soundPlayer.play(self.soundPlayer.soundProvider.wrongSound)
            
            // Find the button with the correct answer
            for button in self.buttons {
                if button.tag == correctAnswer - 1 {
                    
                    // Button style
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
        confetti.isHidden = false
        grayView.backgroundColor = UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0)
        
        questionField.text = "Way to go!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsPerRound) correct!"
        
        if gameManager.correctQuestions == gameManager.questionsPerRound {
            soundPlayer.play(soundPlayer.soundProvider.cheeringSound)
        } else {
            soundPlayer.play(soundPlayer.soundProvider.roundCompleteSound)
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
        disableAllButtons()
        
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
        displayQuestion()
        soundPlayer.play(soundPlayer.soundProvider.startGameSound)
        
        // Styles
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
