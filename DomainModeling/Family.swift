//
//  Family.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/14/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

class Family {
    var members : [Person]
    
    init(members : [Person]) {
        self.members = members
    }
    
    /**
     * Compute the household income for a full work year
     */
    func householdIncome() -> Money {
        var income = Money.ZERO
        
        for member in members {
            if member.job != nil {
                income.add(member.job!.calculateIncome(SalaryJob.yearlyHours))
            }
        }
        
        return income
    }
    
    /**
     * Have a new child
     */
    func haveChild(firstName : String, lastName : String) {
        members.append(Person(firstName: firstName, lastName: lastName, age: 0))
    }
}