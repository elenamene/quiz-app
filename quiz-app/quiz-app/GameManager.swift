//
//  ​GameManager.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 01/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

import GameKit

// QuizManager ​object ​which ​could ​initialize ​the ​Questions ​and ​add ​them ​to ​the
// Quiz, ​randomize ​the ​set ​of ​Questions, ​check ​if ​the ​answer ​is ​correct, ​etc.


class GameManager {
    var quiz = Quiz()
    var questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var score = 0
    var previousQuestionIndexes = [Int]()
    
    func getRandomQuestion() -> Question {
        // Get random index
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.questions.count)
        
        // Check for non repeating questions
        while previousQuestionIndexes.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.questions.count)
        }
        
        // Append array of indexes
        previousQuestionIndexes.append(indexOfSelectedQuestion)
        
        // Update question counter
        questionsAsked += 1
        
        return quiz.questions[indexOfSelectedQuestion]
    }
    
    func isCorrect(_ optionSelected: Int) -> Bool {
        let currentQuestion = quiz.questions[indexOfSelectedQuestion]
        if optionSelected == (currentQuestion.correctAnswer - 1) {
            correctQuestions += 1
            score += 1
            return true
        } else {
            return false
        }
    }
}
