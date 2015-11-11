//
//  AnswerViewController.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 11/10/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var questionController: QuestionViewController?
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var choiceOne: UIButton!
    @IBOutlet weak var choiceTwo: UIButton!
    @IBOutlet weak var choiceThree: UIButton!
    @IBOutlet weak var choiceFour: UIButton!
    
    private var choices: [UIButton] = []
    
    override func viewDidLoad() {
        choices = [choiceOne, choiceTwo, choiceThree, choiceFour]
    }
    
    override func viewWillAppear(animated: Bool) {
        var currentQuestion = questionController!.quiz!.questions[questionController!.currentQuestion!]
        
        questionLabel.text = currentQuestion.question
        
        choiceOne.setTitle(currentQuestion.answers[0], forState: .Normal)
        choiceTwo.setTitle(currentQuestion.answers[1], forState: .Normal)
        choiceThree.setTitle(currentQuestion.answers[2], forState: .Normal)
        choiceFour.setTitle(currentQuestion.answers[3], forState: .Normal)
        
        var tintColor = UIColor.redColor()
        
        if questionController!.quiz!.questions[questionController!.currentQuestion!].correctAnswer == questionController!.currentlySelectedAnswer! {
            tintColor = UIColor.greenColor()
        }
        
        for var choice in choices {
            choice.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        
        choices[questionController!.currentlySelectedAnswer!].setTitleColor(tintColor, forState: .Normal)
    }
    
    @IBAction func nextQuestionTapped(sender: AnyObject) {
        if ++self.questionController!.currentQuestion! >= self.questionController?.quiz?.questions.count {
            // We can exit now since they're at the end of the quiz
            self.performSegueWithIdentifier("ShowFinishQuiz", sender: sender)
            
            return
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowFinishQuiz" {
            let destinationController = segue.destinationViewController as! FinishQuizViewController
            
            destinationController.score = questionController?.questionsCorrect!
            destinationController.total = questionController?.quiz!.questions.count
        }
    }
    
}