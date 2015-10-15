//
//  Person.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/14/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

class Person : CustomStringConvertible {
    static var minimumJobAge : Int = 16
    static var minimumMarriageAge : Int = 18
    
    var firstName : String
    var lastName : String
    
    var age : Int
    
    var job : Job? {
        didSet(newJob) {
            if self.age < Person.minimumJobAge {
                self.job = nil
            }
        }
    }
    
    var spouse : Person? {
        didSet(newSpouse) {
            if self.age < Person.minimumMarriageAge {
                self.spouse = nil
            }
        }
    }
    
    var description : String {
        return "\(firstName) \(lastName), Age \(age)"
    }
    
    init(firstName : String, lastName : String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName

        self.age = age
    }
}