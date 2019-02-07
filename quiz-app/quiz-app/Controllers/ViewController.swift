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
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var confettiView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionTracker: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
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
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.applyGradient(colorOne: UIColor(red:0.00, green:0.87, blue:0.84, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0))
        soundPlayer.play(soundPlayer.soundProvider.startGameSound)
        
        // Start game
        displayQuestion()
        
        // Observers
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimeOver), name: Notification.Name(rawValue: "timeOver"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimeReset), name: Notification.Name(rawValue: "timeReset"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Game Management
    
    func displayQuestion() {
        questionLabel.text = gameManager.newQuestion()?.question
        questionTracker.text = "Question \(gameManager.questionsCount) of \(gameManager.questionsPerRound)"
        displayOptionButtons()
        
        // start timer
        timer.start()
        progressBar.setProgress(timer.secondsRemaining, animated: true)
    }
    
    func displayOptionButtons() {
        // Reset display removing all buttons
        resetDisplay()
        
        // create buttons depending on number of answers of the selected question
        let numberOfAnswers = gameManager.currentQuestion?.possibleAnswers.count
        
        switch numberOfAnswers {
        case 1: buttons += [option1Button]
        case 2: buttons += [option1Button, option2Button]
        case 3: buttons += [option1Button, option2Button, option3Button]
        case 4: buttons += [option1Button, option2Button, option3Button, option4Button]
        default: break
        }
        
        for button in buttons {
            let index = button.tag
            button.setTitle(gameManager.currentQuestion?.possibleAnswers[index], for: .normal)
            button.isHidden = false
            button.isEnabled = true
            button.applyStyle(.normal)
        }
    }
    
    func nextRound() {
        resetButtonsStyle()
        if gameManager.questionsCount == gameManager.questionsPerRound {
            // Game is over
            displayScore()
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
    
    func highlightCorrectAnswer() {
        guard let correctAnswer = self.gameManager.currentQuestion?.correctAnswer else {
            return
        }
        
        // Find the button with the correct answer and apply style
        for button in self.buttons {
            if button.tag == correctAnswer - 1 {
                button.applyStyle(.correctButton)
            }
        }
    }
    
    func displayScore() {
        hideOptionsButtons()
        playAgainButton.isHidden = false
        containerView.backgroundColor = UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0)
        
        questionLabel.text = "Way to go!\nYou got \(gameManager.correctAnswersCount) out of \(gameManager.questionsPerRound) correct!"
        
        // Play cheering sound if user gets all correct answers
        if gameManager.correctAnswersCount == gameManager.questionsPerRound {
            soundPlayer.play(soundPlayer.soundProvider.cheeringSound)
        } else {
            soundPlayer.play(soundPlayer.soundProvider.roundCompleteSound)
        }
    }
    
    // MARK: - Buttons Management
    
    func resetDisplay() {
        hideOptionsButtons()
        resetButtonsStyle()
        buttons = []
        confettiView.isHidden = true
        playAgainButton.isHidden = true
        questionLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
    func resetButtonsStyle() {
        for button in buttons { button.applyStyle(.normal) }
        playAgainButton.applyStyle(.normal)
        playAgainButton.setTitleColor(UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0), for: .normal)
        playAgainButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func hideOptionsButtons() {
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
    
    // MARK: - Notification objects
    
    @objc func handleTimeOver(notification: NSNotification) {
        questionLabel.text = "Time Over! ⌛️"
        questionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        highlightCorrectAnswer()
        disableAllButtons()
        
        // Time reset
        timer.reset()
        
        // call next round
        loadNextRound(delay: 3)
    }
    
    @objc func handleTimeReset(notification: NSNotification) {
        progressBar.setProgress(0, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        disableAllButtons()
        sender.applyStyle(.pressed)
        questionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        // Check if the answer is correct and display feedback
        if gameManager.isCorrect(sender.tag) {
            // Correct answer
            questionLabel.text = "Correct! 🎉"
            soundPlayer.play(soundPlayer.soundProvider.correctSound)
            sender.applyStyle(.correctButton)
        } else {
            // Wrong answer
            questionLabel.text = "Sorry, that's not it. 😬"
            sender.applyStyle(.wrongButton)
            // Highlight the correct answer after a delay of 0.4
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
                self.highlightCorrectAnswer()
                self.soundPlayer.play(self.soundPlayer.soundProvider.wrongSound)
            }
        }
        
        // reset timer
        timer.reset()
        
        // call next round
        loadNextRound(delay: 2)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        gameManager.resetGame()
        nextRound()
        
        // Change background
        containerView.backgroundColor = UIColor(red:0.96, green:0.97, blue:0.98, alpha:1.0)
        
        // Play Sound
        soundPlayer.play(soundPlayer.soundProvider.startGameSound)
    }

}

