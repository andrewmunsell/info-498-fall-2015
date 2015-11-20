//
//  QueueUtils.swift
//  iOSQuiz
//
//  Created by Andrew Munsell on 11/19/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

// Helper variables from
// http://www.raywenderlich.com/79149/grand-central-dispatch-tutorial-swift-part-1
var GlobalMainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
}

var GlobalUserInitiatedQueue: dispatch_queue_t {
    return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
}