//
//  FinishQuizViewController.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 11/10/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class FinishQuizViewController: UIViewController {
    var score: Int?
    var total: Int?
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        let percent: Double = Double(score!) / Double(total!)
        
        if percent == 1 {
            messageLabel.text = "Amazing! 100%!"
        } else if percent > 0.9 {
            messageLabel.text = "Great job! Almost there!"
        } else if percent > 0.75 {
            messageLabel.text = "Nice job!"
        } else if percent > 0.5 {
            messageLabel.text = "You're getting close..."
        } else {
            messageLabel.text = "What. Was. That."
        }
        
        scoreLabel.text = "\(score!) / \(total!)"
    }
}