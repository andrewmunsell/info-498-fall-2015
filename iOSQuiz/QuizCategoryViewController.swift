//
//  ViewController.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 10/29/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class QuizCategoryViewController: UIViewController, UITableViewDataSource {
    let tableData = [
        QuizCategory(title: "Math", description: "Numbers and equations", icon: "math"),
        QuizCategory(title: "Science", description: "Chemistry, biology, physics and more", icon: "science"),
        QuizCategory(title: "Marvel Super Heros", description: "One of these categories does not belong...", icon: "hero")
    ];
    
    @IBOutlet weak var categoryTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.dataSource = self
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
}

