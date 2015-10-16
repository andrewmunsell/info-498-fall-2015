//
//  SalaryJob.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/14/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

class SalaryJob : Job {
    // Number of hours in a year
    static var yearlyHours = 2000
    
    /**
     * Set a custom description for the job
     */
    override var description : String {
        return "\(self.title): $\(self.pay.amount) yearly"
    }

    /**
     * Calculate the income, ignoring the number of hours since this is a salaried job.
     */
    override func calculateIncome(hours : Int) -> Money {
        return self.pay
    }
}