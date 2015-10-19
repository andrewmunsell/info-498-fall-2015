//
//  Mathematics.swift
//  DomainModeling
//
//  Created by Andrew Munsell on 10/19/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

protocol Mathematics {
    mutating func add(other : Money)
    mutating func sub(other : Money)
}