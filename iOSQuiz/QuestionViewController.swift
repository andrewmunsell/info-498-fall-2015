//
//  QuestionViewController.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 11/10/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var quiz: QuizCategory?
    
    var currentQuestion: Int?
    var questionsCorrect: Int?
    
    var currentlySelectedAnswer: Int?
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var choiceFour: UIButton!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        nextButton.enabled = false
        
        // Assign the labels for the buttons
        let currentQuestion: QuizQuestion = self.quiz!.questions[self.currentQuestion!]
        
        questionLabel!.text = currentQuestion.question
        
        choiceOne.setTitle(currentQuestion.answers[0], forState: .Normal)
        choiceTwo.setTitle(currentQuestion.answers[1], forState: .Normal)
        choiceThree.setTitle(currentQuestion.answers[2], forState: .Normal)
        choiceFour.setTitle(currentQuestion.answers[3], forState: .Normal)
        
        choiceOne.selected = false
        choiceTwo.selected = false
        choiceThree.selected = false
        choiceFour.selected = false
        
        currentlySelectedAnswer = nil
    }
    
    @IBAction func choiceOneTapped(sender: AnyObject) {
        nextButton.enabled = true
        
        currentlySelectedAnswer = 0
        
        choiceOne.selected = true
        choiceTwo.selected = false
        choiceThree.selected = false
        choiceFour.selected = false
    }
    
    @IBAction func choiceTwoTapped(sender: AnyObject) {
        nextButton.enabled = true
        
        currentlySelectedAnswer = 1
        
        choiceOne.selected = false
        choiceTwo.selected = true
        choiceThree.selected = false
        choiceFour.selected = false
    }
    
    @IBAction func choiceThreeTapped(sender: AnyObject) {
        nextButton.enabled = true

        currentlySelectedAnswer = 2
        
        choiceOne.selected = false
        choiceTwo.selected = false
        choiceThree.selected = true
        choiceFour.selected = false
    }
    
    @IBAction func choiceFourTapped(sender: AnyObject) {
        nextButton.enabled = true

        currentlySelectedAnswer = 3
        
        choiceOne.selected = false
        choiceTwo.selected = false
        choiceThree.selected = false
        choiceFour.selected = true
    }
    
    @IBAction func nextButtonTapped(sender: AnyObject) {
        if currentlySelectedAnswer! == quiz?.questions[currentQuestion!].correctAnswer {
            questionsCorrect!++
        }
        
        self.performSegueWithIdentifier("ShowAnswer", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowAnswer" {
            let destinationController: AnswerViewController = segue.destinationViewController as! AnswerViewController
            
            destinationController.questionController = self
        }
    }
}