//
//  main.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/14/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

// Money

var dollarUsd = Money(amount: 1.0, currency: Currency.USD)
var twoDollarsUsd = Money(amount: 2.0, currency: Currency.USD)
var oneGbp = Money(amount: 1.0, currency: Currency.GBP)

dollarUsd.add(twoDollarsUsd)

print("Result: \(dollarUsd)")

dollarUsd.add(oneGbp)

print("Result: \(dollarUsd)")

dollarUsd.sub(twoDollarsUsd)

print("Result: \(dollarUsd)")

dollarUsd.convert(Currency.CAN)

print("Result: \(dollarUsd)")

dollarUsd.convert(Currency.GBP)
dollarUsd.convert(Currency.EUR)
dollarUsd.convert(Currency.USD)

print("Result: \(dollarUsd)")

// Job

var ta = HourlyJob(title: "Teaching Assistant", pay: Money(amount: 15.0))
var programmer = SalaryJob(title: "Programmer", pay: Money(amount: 100000.0))

print("Pay of TA over 15 hours: " + String(ta.calculateIncome(15)))

ta.raise(0.02)

print("Pay of TA after a raise: " + String(ta.calculateIncome(15)))

// Person

var child = Person(firstName: "John", lastName: "Doe", age: 12)

var sally = Person(firstName: "Sally", lastName: "Smith", age: 24)
sally.job = ta

var dave = Person(firstName: "Dave", lastName: "Smith", age: 25)
dave.job = programmer

// Try and add a job
child.job = ta

if child.job != nil {
    print("CHILD LABOR ALERT") // This should not be printed
}

child.spouse = sally

if child.spouse != nil {
    print("Children should not be married this young.") // This should not be printed
}

print("Child: \(child)") // Should use the custom description

// Family

var family = Family(members: [dave, sally, child])

print("Income: " + String(family.householdIncome()))

family.haveChild("Lisa", lastName: "Jobs")

print("Family members: " + String(family.members.count))

print("Is legal? " + String(family.isLegal()))