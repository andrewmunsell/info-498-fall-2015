//
//  Money.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/14/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

enum Currency : Double {
    case USD = 1
    case CAN = 1.25
    case GBP = 0.5
    case EUR = 1.5
}

enum CurrencyError : ErrorType {
    case InvalidCurrency
}

struct Money : CustomStringConvertible {
    var amount : Double
    var currency : Currency
    
    /**
     * Specify a custom description
     */
    var description : String {
        return String(self.amount) + " " + String(self.currency)
    }
    
    // An empty money object for convenience
    static var ZERO = Money(amount: 0.0)
    
    init(amount : Double, currency : Currency = Currency.USD) {
        self.amount = amount
        self.currency = currency
    }
    
    /**
     * Convert the current money to the specified currency type
     */
    mutating func convert(currency : Currency) {
        // If we are converting to the same type of currency, we can just short circuit
        if currency  == self.currency {
            return
        }
        
        // Convert to USD first
        self.amount /= self.currency.rawValue
        
        // Now, convert to the target
        self.amount *= currency.rawValue
        
        self.currency = currency
    }
    
    /**
     * Add the other money to this one, modifying the original
     */
    mutating func add(other : Money) {
        let originalCurrency = self.currency
        
        self.convert(other.currency)
        self.amount += other.amount
        
        self.convert(originalCurrency)
    }
    
    /**
     * Subtract the other money to this one, modifying the original
     */
    mutating func sub(other : Money) {
        let originalCurrency = self.currency
        
        self.convert(other.currency)
        self.amount -= other.amount
        
        self.convert(originalCurrency)
    }
}