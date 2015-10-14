//
//  main.swift
//  AdvancedCalculator
//
//  Created by Andrew Munsell on 10/13/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

// Tests for basic calculator functions

// Addition
print("1 + 1 = 2 -> " + String(add(1, b: 1)))
print("2 + 1 = 3 -> " + String(add(2, b: 1)))

// Subtraction
print("1 - 1 = 0 -> " + String(sub(1, b: 1)))
print("5 - 1 = 4 -> " + String(sub(5, b: 1)))

// Multiplication
print("1 * 1 = 1 -> " + String(mul(1, b: 1)))
print("5 * 1 = 5 -> " + String(mul(5, b: 1)))
print("5 * 0 = 0 -> " + String(mul(5, b: 0)))

// Divide
print("1 / 1 = 1 -> " + String(div(1, b: 1)))
print("1 / 2 = 0 -> " + String(div(1, b: 2))) // It's integer division

// op
print("op() 1 + 1 = 2 -> " + String(op(add, a: 1, b: 1)))
print("op() 1 - 1 = 0 -> " + String(op(sub, a: 1, b: 1)))

// Array Addition
print("[] 1 + 2 + 3 = 6 -> " + String(addAll([1, 2, 3])))

// Array Multiplication
print("[] 1 * 2 * 4 = 8 -> " + String(addAll([1, 2, 4])))

// Array Count
print("count [1, 2, 3] = 3 -> " + String(count([1, 2, 3])))

// Array Average
print("avg [1, 2, 3] = 2.0 -> " + String(avg([1, 2, 3])))

// Array op
print("op() [] 1 + 2 + 3 = 6 -> " + String(op(addAll, nums: [1, 2, 3])))
print("op() [] 1 * 2 * 4 = 8 -> " + String(op(mulAll, nums: [1, 2, 4])))

// Point Add
print("(1, 2) + (2, 3) = (3, 5) -> " + String(addPoints((x: 1, y: 2), b: (x: 2, y: 3))))

// Point Subtract
print("(1, 2) - (2, 3) = (-1, -1) -> " + String(subPoints((x: 1, y: 2), b: (x: 2, y: 3))))

// Handle points w/o X/Y
// Point Add
let a : [String: Int] = ["y": 2]
let b : [String: Int] = ["x": 1, "y": 3]

let ad : [String: Double] = ["x": 3.0, "y": 2.5]
let bd : [String: Double] = ["x": 1.2, "y": 3.0]

print("(3.0, 2.5) + (1.2, 3.0) = (1.8, -0.5) -> " + String(subPoints(ad, b: bd)))