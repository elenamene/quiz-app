//
//  Quiz.swift
//  UxQuizApp
//
//  Created by Elena Meneghini on 01/08/2018.
//  Copyright © 2018 Elena Meneghini. All rights reserved.
//

// Provide random questions
struct Questions {
    let list = [
        Question(
            question: "What's the percentage of accessibility issues related to blindness?",
            possibleAnswers: ["35%", "55%", "80%", "90%"],
            correctAnswer: 3),
        Question(
            question: "Learnability, efficiency, memorability and utility are all components that define:",
            possibleAnswers: ["Accessibility", "Visual Design", "User Experience", "Usability"],
            correctAnswer: 4),
        Question(
            question: "What's the name of the first person been called \"User Experience Architect\"?",
            possibleAnswers: ["Patrick Neeman", "Don Norman", "Henry Dreyfuss", "Steve Jobs"],
            correctAnswer: 2),
        Question(
            question: "What does MVP stand for?",
            possibleAnswers: ["Minimum Viable Product", "Most Valuable Player", "Most Valuable Product"],
            correctAnswer: 1),
        Question(
            question: "How many phases are there in a Google Design Sprint?",
            possibleAnswers: ["6", "4", "5", "3"],
            correctAnswer: 3),
        Question(
            question: "User research is a discipline focused on:",
            possibleAnswers: ["User wants and user behaviours", "User needs and user behaviours", "User experience and business requirements ", "What people think they need"],
            correctAnswer: 2),
        Question(
            question: "What's the best research method if you want to to observe users in their natural environment?",
            possibleAnswers: ["Focus Groups", "Surveys", "Contextual Interviews", "User Interviews"],
            correctAnswer: 3),
        Question(
            question: "The creation of a representative user based on available data and user interviews is called:",
            possibleAnswers: ["KPI", "Target Customer", "Persona", "Focus Group"],
            correctAnswer: 3),
        Question(
            question: "Can users be stackholders?",
            possibleAnswers: ["Yes", "No"],
            correctAnswer: 1),
        Question(
            question: "Visual hierarchy influences the path that a user's eye will take when scanning the page.",
            possibleAnswers: ["True", "False"],
            correctAnswer: 1),
        Question(
            question: "In designs with a lot of text we scan the page following the Z pattern.",
            possibleAnswers: ["True", "False"],
            correctAnswer: 2),
        Question(
            question: "What type of wireframes is better for documentation because of their increased level of detail?",
            possibleAnswers: ["Low-fidelity wireframes", "High-fidelity wireframes"],
            correctAnswer: 2),
        Question(
            question: "What's the name of the study of the way people perform tasks with existing systems?",
            possibleAnswers: ["Heuristic evaluation", "Competitor Benchmarking","Task Analysis", "User Journey"],
            correctAnswer: 3),
        Question(
            question: "Sites that change appearance based on the browser environment they are being viewed on, are: ",
            possibleAnswers: ["Adaptive", "Responsive","All of the above"],
            correctAnswer: 3),
        Question(
            question: "Which of the following is not a type of microcontent?",
            possibleAnswers: ["Page titles", "Email subjects","Taglines", "Articles"],
            correctAnswer: 4),
        Question(
            question: "Research on short-term memory reported that we can only store a few chunks of information. How many?",
            possibleAnswers: ["3", "5","7"],
            correctAnswer: 3),
        Question(
            question: "Which of the following is not true?",
            possibleAnswers: ["Toggle switches have a default value", "Switches are used to toggle between two options","With toggles the action is saved once the user hit save button", "Switches are more appropriate for multitouch interactions"],
            correctAnswer: 3),
        ]
}


