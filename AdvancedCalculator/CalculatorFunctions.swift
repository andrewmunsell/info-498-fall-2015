//
//  CalculatorFunctions.swift
//  AdvancedCalculator
//
//  Created by Andrew Munsell on 10/13/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

func add(a : Int, b : Int) -> Int {
    return a + b
}

func sub(a : Int, b : Int) -> Int {
    return a - b
}

func mul(a : Int, b : Int) -> Int {
    return a * b
}

func div(a : Int, b : Int) -> Int {
    return a / b
}

func mod(a : Int, b : Int) -> Int {
    return a % b
}

func op(op : (Int, Int) -> Int, a : Int, b : Int) -> Int {
    return op(a, b)
}