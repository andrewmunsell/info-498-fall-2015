//
//  ViewController.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 10/29/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class QuizCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let tableData = [
        QuizCategory(title: "Math", description: "Numbers and equations", icon: "math", questions: [
            QuizQuestion(question: "What is 1 + 1?", answers: ["1", "2", "3", "4"], correctAnswer: 1),
            QuizQuestion(question: "What is 5 + 5?", answers: ["1", "3", "10", "25"], correctAnswer: 2),
            QuizQuestion(question: "What is 45 * 1 + 1?", answers: ["6", "45", "46", "40"], correctAnswer: 2)
        ]),
        
        QuizCategory(title: "Science", description: "Chemistry, biology, physics and more", icon: "science", questions: [
            QuizQuestion(question: "How many fingers does a human have on average?", answers: ["5", "8", "10", "100"], correctAnswer: 3),
            QuizQuestion(question: "\"He\" is the atomic symbol for which element?", answers: ["Helium", "Hydrogen", "Boron", "Chlorine"], correctAnswer: 0)
        ]),
        
        QuizCategory(title: "Marvel Super Heros", description: "One of these categories does not belong...", icon: "hero", questions: [
                QuizQuestion(question: "What is the name of the super hero that wears a red suit of armor?", answers: ["Hulk", "Iron Man", "Spiderman", "Nighthawk"], correctAnswer: 1)
            ])
    ];
    
    private var currentQuiz: QuizCategory?
    
    @IBOutlet weak var categoryTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.dataSource = self
        categoryTable.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.categoryTable.dequeueReusableCellWithIdentifier("CategoryCell")! as UITableViewCell
        
        let subjectLabel = cell.viewWithTag(10) as! UILabel
        subjectLabel.text = tableData[indexPath.row].title
        
        let descLabel = cell.viewWithTag(20) as! UILabel
        descLabel.text = tableData[indexPath.row].description
        
        if tableData[indexPath.row].icon != nil {
            let img = cell.viewWithTag(25) as! UIImageView
            img.image = UIImage(named: tableData[indexPath.row].icon!)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentQuiz = tableData[indexPath.row]
        
        self.performSegueWithIdentifier("BeginQuiz", sender: nil)
    }

    @IBAction func settingsButtonTapped(sender: UIBarButtonItem) {
        let settings = UIAlertController(title: "Settings", message: "The settings dialog would go here.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        settings.addAction(cancelAction)
        
        self.presentViewController(settings, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == "BeginQuiz" {
            // Get the destination controller and assign the quiz to the destination controller
            let destinationController = segue.destinationViewController as! QuestionViewController
            
            destinationController.quiz = self.currentQuiz
            
            destinationController.currentQuestion = 0
            destinationController.questionsCorrect = 0
        }
    }
}

