//
//  ArrayFunctions.swift
//  AdvancedCalculator
//
//  Created by Andrew Munsell on 10/13/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

func addAll(nums : [Int]) -> Int {
    return nums.reduce(0, combine: { $0 + $1 })
}

func mulAll(nums : [Int]) -> Int {
    return nums.reduce(1, combine: { $0 * $1 })
}

func count(nums : [Int]) -> Int {
    return nums.count
}

func avg(nums : [Int]) -> Double {
    return Double(addAll(nums)) / Double(count(nums))
}

func op<T>(op : ([Int]) -> T, nums : [Int]) -> T {
    return op(nums)
}