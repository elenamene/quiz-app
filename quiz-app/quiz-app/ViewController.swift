//
//  ViewController.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 01/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let gameManager = GameManager()
    let timer = questionTimer()
    var buttons = [UIButton]()
    
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
            sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        } else {
            questionField.text = "Sorry, that's not it. 😬"
            // highlight wrong answer
            sender.layer.borderColor = UIColor(red:0.96, green:0.35, blue:0.57, alpha:1.0).cgColor
            // Highlight correct answer
            let correctAnswer = self.gameManager.quiz.questions[self.gameManager.indexOfSelectedQuestion].correctAnswer
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4) {
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
    }
    
    // MARK: - Helpers
    
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
        default: print("This questions has no answers")
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
    }
    
    func displayScore() {
        hideAllButtons()
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(gameManager.correctQuestions) out of \(gameManager.questionsPerRound) correct!"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayQuestion()
        
        // Buttons styles
        playAgainButton.applyGradientStyle(colorOne: UIColor(red:0.00, green:0.87, blue:0.84, alpha:0.5), colorTwo: UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0))
        
        // Header style
        header.applyGradient(colorOne: UIColor(red:0.00, green:0.87, blue:0.84, alpha:1.0), colorTwo: UIColor(red:0.00, green:0.78, blue:0.90, alpha:1.0))
        
        questionTracker.text = "Question \(gameManager.questionsAsked) of \(gameManager.questionsPerRound)"
        
        // Progress bar
        if timer.isOn {
            progressBar.isHidden = false
            progressBar.setProgress(timer.secondsRemaining, animated: true)
        } else {
            progressBar.setProgress(0, animated: false)
            progressBar.isHidden = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

