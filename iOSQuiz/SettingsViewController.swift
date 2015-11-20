//
//  SettingsViewController.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 11/19/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: nil, action: "dismissSettings:")
        
        navItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: nil, action: "refresh:")
    }
    
    override func viewWillAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let url = userDefaults.stringForKey("url")!
        
        urlTextField.text = url
    }
    
    func dismissSettings(sender: AnyObject?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func refresh(sender: AnyObject?) {
        // Save the URL to the user defaults
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(urlTextField.text!, forKey: "url")
        userDefaults.synchronize()
        
        QuizDataManager.refresh { (err: NSError?) -> Void in
            var message: String;
            if err != nil {
                message = "There was a problem refreshing the questions."
            } else {
                message = "The questions refreshed successfully."
            }

            let alert = UIAlertController(title: "Refresh Questions", message: message, preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alert.addAction(cancelAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}