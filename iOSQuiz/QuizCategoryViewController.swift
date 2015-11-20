//
//  ViewController.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 10/29/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class QuizCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableData: [QuizCategory] = [];
    
    private var currentQuiz: QuizCategory?
    
    @IBOutlet weak var categoryTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.dataSource = self
        categoryTable.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        QuizDataManager.getQuizzes { (err: NSError?, quizzes: [QuizCategory]?) -> Void in
            self.tableData = quizzes!
            
            self.categoryTable.reloadData()
        }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != nil && segue.identifier! == "BeginQuiz" {
            // Get the destination controller and assign the quiz to the destination controller
            let destinationController = segue.destinationViewController as! QuestionViewController
            
            destinationController.quiz = self.currentQuiz
            
            destinationController.currentQuestion = 0
            destinationController.questionsCorrect = 0
        }
    }
}

