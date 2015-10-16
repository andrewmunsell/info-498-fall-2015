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
    
    /**
     * Set a custom description for the family
     */
    var description : String {
        return "Family (\(self.members.count) members)"
    }
    
    init(members : [Person]) {
        self.members = members
    }
    
    /**
     * Return a boolean indicating whether the family is legal or not. A legal family
     * has at least one person that is at least 21 years of age.
     */
    func isLegal() -> Bool {
        var isLegal : Bool = false
        
        for member in self.members {
            if member.age >= 21 {
                isLegal = true
            }
        }
        
        return isLegal
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