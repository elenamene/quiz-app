//
//  ​GameManager.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 01/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

// QuizManager ​object ​which ​could ​initialize ​the ​Questions ​and ​add ​them ​to ​the
// Quiz, ​randomize ​the ​set ​of ​Questions, ​check ​if ​the ​answer ​is ​correct, ​etc.

class GameManager {
    var questions = Questions()
    var questionsPerRound = 5
    var currentQuestion: Question?
    var indexesUsed: [Int] = []
    var questionsCount = 0
    var correctAnswersCount = 0
    var score = 0
    
    func newQuestion() -> Question? {
        var randomIndex: Int
        
        repeat {
            randomIndex = Int.random(in: 0..<questions.list.count)
        } while indexesUsed.contains(randomIndex)
        
        currentQuestion = questions.list[randomIndex]
        questionsCount += 1
        indexesUsed.append(randomIndex)
        
        return currentQuestion
    }
    
    func isCorrect(_ optionSelected: Int) -> Bool {
        if let currentQuestion = currentQuestion, optionSelected == (currentQuestion.correctAnswer - 1) {
            correctAnswersCount += 1
            score += 1
            return true
        } else {
            return false
        }
    }
    
    func resetGame() {
        questionsCount = 0
        correctAnswersCount = 0
        score = 0
        indexesUsed.removeAll()
    }
}
