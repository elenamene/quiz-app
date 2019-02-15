# UX Quiz App

## iOS Techdegree Project 2

Simple quiz app that displays a mix of 2,3 or 4 choice questions.
Correct answer is displayed when player guesses incorrectly.
Game includes a lightning mode with 15 seconds countdown timer for each question set.

![image of the app](https://github.com/elenamene/quiz-app/blob/master/screenshot2.png)

### Required Tasks

1. Convert the Storyboard back to a universal scene and add constraints to maintain the layout such all UI elements are sized and spaced appropriately for all iPhones of screen sizes 4.7 and 5.5. inches.

2. Refactor the existing code such that individual questions are modeled using a class or struct.

3. Ensure that code adheres to the MVC pattern.

4. Enhance the quiz so it can accommodate four answer choices for each question, as shown in the mockups and sample question set.

5. Add functionality such that during each game, questions are chosen at random, though no question will be repeated within a single game.

### Extra Credit

6. Implement a feature so that the app can neatly display a mix of 3-option questions as well as 4-option questions. Inactive buttons should be spaced or resized appropriately, not simply hidden, disabled, or marked as unused (e.g. with the string ‘N/A’). You need to implement this feature using only one view controller.

7. Implement a way to appropriately display the correct answer, when a player answers incorrectly.

8. Modify the app to be in "lightning" mode where users only have 15 seconds to select an answer for each question. Display the number of correct answers at the end of the quiz.

9. Add two sound effects, one for correct answers and one for incorrect. You may also add sounds at the end of the game, or wherever else you see fit.

### Personal Enhancements

* Added styling to all buttons

* Added progress bar to keep track of the time left in "lightning" mode
