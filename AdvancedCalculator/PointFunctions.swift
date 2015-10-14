//
//  PoDoubleFunctions.swift
//  AdvancedCalculator
//
//  Created by Andrew Munsell on 10/13/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

func intDictToDoubleDict(a : Dictionary<String, Int>?, b : Dictionary<String, Int>?) -> (Dictionary<String, Double>, Dictionary<String, Double>) {
    var ad = Dictionary<String, Double>()
    var bd = Dictionary<String, Double>()
    
    if a != nil && a!["x"] != nil {
        ad["x"] = Double(a!["x"]!)
    }
    
    if a != nil && a!["y"] != nil {
        ad["y"] = Double(a!["y"]!)
    }
    
    if b != nil && b!["x"] != nil {
        bd["x"] = Double(b!["x"]!)
    }
    
    if b != nil && b!["y"] != nil {
        bd["y"] = Double(b!["y"]!)
    }
    
    return (ad, bd);
}

func addPoints(a : (x: Double, y: Double), b : (x: Double, y: Double)) -> (Double, Double) {
    return (a.x + b.x, a.y + b.y)
}

func addPoints(a : Dictionary<String, Int>?, b : Dictionary<String, Int>?) -> (Double, Double) {
    let (ad, bd) = intDictToDoubleDict(a, b: b)
    
    return addPoints(ad, b: bd)
}

func addPoints(var a : Dictionary<String, Double>?, var b : Dictionary<String, Double>?) -> (Double, Double) {
    if a == nil {
        a = Dictionary<String, Double>()
    }
    
    if b == nil {
        b = Dictionary<String, Double>()
    }

    return addPoints((x: a!["x"] != nil ? a!["x"]! : 0, y: a!["y"] != nil ? a!["y"]! : 0),
        b: (x: b!["x"] != nil ? b!["x"]! : 0, y: b!["y"] != nil ? b!["y"]! : 0))
}

func subPoints(a : (x: Double, y: Double), b : (x: Double, y: Double)) -> (Double, Double) {
    return (a.x - b.x, a.y - b.y)
}

func subPoints(var a : Dictionary<String, Double>?, var b : Dictionary<String, Double>?) -> (Double, Double) {
    if a == nil {
        a = Dictionary<String, Double>()
    }
    
    if b == nil {
        b = Dictionary<String, Double>()
    }
    
    return subPoints((x: a!["x"] != nil ? a!["x"]! : 0, y: a!["y"] != nil ? a!["y"]! : 0),
        b: (x: b!["x"] != nil ? b!["x"]! : 0, y: b!["y"] != nil ? b!["y"]! : 0))
}

func subPoints(a : Dictionary<String, Int>?, b : Dictionary<String, Int>?) -> (Double, Double) {
    let (ad, bd) = intDictToDoubleDict(a, b: b)
    
    return subPoints(ad, b: bd)
}