//
//  QuizDataManager.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 11/19/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

class QuizDataManager {
    static func refresh(callback: (NSError?) -> Void) {
        dispatch_async(GlobalUserInitiatedQueue) { () -> Void in
            // Load the JSON from the URL that is currently stored in the user defaults
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let url = userDefaults.stringForKey("url")!
            
            do {
                let json = try String(contentsOfURL: NSURL(string: url)!)
                
                userDefaults.setValue(json, forKey: "json")
                userDefaults.synchronize()
                
                dispatch_async(GlobalMainQueue, { () -> Void in
                    callback(nil)
                })
            } catch {
                dispatch_async(GlobalMainQueue, { () -> Void in
                    callback(nil)
                })
            }
        }
    }
    
    static func getQuizzes(callback: (NSError?, [QuizCategory]?) -> Void) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let json = userDefaults.stringForKey("json")
        
        if json == nil {
            QuizDataManager.refresh({ (err: NSError?) -> Void in
                if err != nil {
                    callback(err, nil)
                } else {
                    QuizDataManager.getQuizzes(callback)
                }
            })
        } else {
            let parsedJson = try! NSJSONSerialization.JSONObjectWithData(json!.dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments)
            
            var cats: [QuizCategory] = []
            
            if let categories = parsedJson as? NSArray {
                for var i = 0; i < categories.count; i++ {
                    var qs: [QuizQuestion] = []
                    
                    if let questions = categories[i]["questions"] as? NSArray {
                        for var i = 0; i < questions.count; i++ {
                            let question = QuizQuestion(
                                question: questions[i]["text"] as! String,
                                answers: questions[i]["answers"] as! [String],
                                correctAnswer: Int(questions[i]["answer"] as! String)! - 1
                            )
                            
                            qs.append(question)
                        }
                    }
                    
                    let category = QuizCategory(
                        title: categories[i]["title"] as! String,
                        description: categories[i]["desc"] as! String,
                        icon: "question",
                        questions: qs
                    )
                    
                    cats.append(category)
                }
            }
            
            callback(nil, cats)
        }
    }
}