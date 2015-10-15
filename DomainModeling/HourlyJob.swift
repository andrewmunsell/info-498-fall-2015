//
//  HourlyJob.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/14/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

class HourlyJob : Job {    
    /**
     * Calculate the income for the specified number of hours
     */
    override func calculateIncome(hours : Int) -> Money {
        var income = Money(amount: self.pay.amount, currency: self.pay.currency)
        
        income.amount *= Double(hours)
        
        return income
    }
}