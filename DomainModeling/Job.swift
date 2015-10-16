//
//  Job.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/14/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

class Job {
    var title : String
    var pay : Money
    
    init(title : String, pay : Money) {
        self.title = title
        self.pay = pay
    }
    
    /**
     * Calculate the income for the job given the number of hours
     */
    func calculateIncome(hours : Int) -> Money {
        return self.pay
    }
    
    /**
     * Provide a raise for the job by the specified percentage
     */
    func raise(percent : Double) {
        self.pay.amount *= (1.0 + percent)
    }
}