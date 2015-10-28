//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Andrew Munsell on 10/22/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // Initialize a new calculator
    private var calculator : Calculator = Calculator()
    
    // Calculator "screen"
    @IBOutlet weak var output: UILabel!
    
    // Operator buttons
    @IBOutlet weak var divideButton: UIButton!

    @IBOutlet weak var multiplyButton: UIButton!

    @IBOutlet weak var subtractButton: UIButton!

    @IBOutlet weak var addButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    /**
     * Clear the calculator
     */
    @IBAction func clearButtonTouchUpInside(sender: UIButton) {
        self.calculator.clear()
        self.output!.text = ""
    }

    /**
     * IBAction for *any* button press in the calculator
     */
    @IBAction func Button(sender: UIButton) {
        switch sender.titleLabel!.text! {
        case "=":
            self.calculator.calculate()
        default:
            self.calculator.push(sender.titleLabel!.text!)
        }
        
        print(self.calculator.inputs)
        
        self.display()
    }
    
    private func display() {
        self.output!.text = self.calculator.display()
    }
    
}

class Calculator {
    private var inputs : [String] = []
    
    private var previousNumberPointer : Int = 0
    private var numberPointer : Int = 0

    init() {
        self.reset()
    }

    /**
     * Push a new input onto the array of inputs
     */
    func push(input : String) {
        // If an operand was hit, then we can immediately move the number
        // pointer.
        if !(input == "." || self.stringToNumber(input) != nil) {
            // Ensure the user didn't just decide to hit an operator without
            // hitting a number first
            if numberPointer >= self.inputs.count {
                return
            }
            
            previousNumberPointer = numberPointer
            numberPointer = inputs.count + 1
            
            switch input {
            case "+", "−", "÷", "×", "%":
                // If this is a dual operand equation and the user has already entered
                // two numbers and is trying to enter a third, perform the calculation
                // before moving on.
                if previousNumberPointer != 0 {
                    self.calculate()
                }
            case "!", "Factorial":
                // If this is a factorial, then we need to calculate the value
                // immediately.
                self.inputs.append(input)
                self.calculate()
                
                return
            default:
                break
            }
        }
        
        // We need to ensure the user doesn't enter multiple decimals in a single
        // number
        if input == "." {
            for var i = self.numberPointer; i < self.inputs.count; i++ {
                if self.inputs[i] == "." {
                    return
                }
            }
        }
        
        // Finally, append the user's input
        self.inputs.append(input)
    }
    
    /**
     * Perform the calculation
     */
    func calculate() {
        // Begin by condensing the numbers, since before they were separated by digit
        for var i = 0; i < self.inputs.count - 1; i++ {
            if (self.stringToNumber(self.inputs[i + 1]) != nil || self.inputs[i + 1] == ".")
                && (self.stringToNumber(self.inputs[i]) != nil || self.inputs[i] == ".") {
                    self.inputs[i] += self.inputs[i + 1]
                    
                    self.inputs.removeAtIndex(i + 1)
                    i--
            }
        }
        
        // Perform the actual calculations

        // We know the operator is in the first position, or this is not a valid calculation
        // in the first place.
        let op : String = self.inputs[1]
        var result : Double? = nil
        
        switch op {
        case "+":
            result = self.stringToNumber(self.inputs[0])!.doubleValue +
                self.stringToNumber(self.inputs[2])!.doubleValue
        case "−":
            result = self.stringToNumber(self.inputs[0])!.doubleValue -
                self.stringToNumber(self.inputs[2])!.doubleValue
        case "×":
            result = self.stringToNumber(self.inputs[0])!.doubleValue *
                self.stringToNumber(self.inputs[2])!.doubleValue
        case "÷":
            // Do not allow divide by zero
            if self.stringToNumber(self.inputs[2])!.doubleValue == 0 {
                self.clear()
                
                return
            }
            
            result = self.stringToNumber(self.inputs[0])!.doubleValue /
                self.stringToNumber(self.inputs[2])!.doubleValue
        case "%":
            // Do not allow divide by zero
            if self.stringToNumber(self.inputs[2])!.doubleValue == 0 {
                self.clear()
                
                return
            }

            result = self.stringToNumber(self.inputs[0])!.doubleValue %
                self.stringToNumber(self.inputs[2])!.doubleValue
        case "!", "Factorial":
            result = self.stringToNumber(self.inputs[0])!.doubleValue
            var current : Int = Int(floor(result!)) - 1
            
            while current > 0 {
                result = result! * Double(current--);
            }
        case "Count":
            result = Double((self.inputs.count + 1) / 2)
        case "Avg", "Average":
            result = 0
            
            for var i = 0; i < self.inputs.count; i += 2 {
                result! += self.stringToNumber(self.inputs[i])!.doubleValue
            }

            if self.inputs.count > 0 {
                result! /= Double((self.inputs.count + 1) / 2)
            }
        default:
            break
        }
        
        // Assign the result to the inputs array because we need it to be displayed, and it
        // can be used for future calculations.
        self.inputs = Array(String(result!).characters).map { String($0) }
        self.numberPointer = 0
        self.previousNumberPointer = 0
    }
    
    /**
     * Get the text to be displayed in the "calculator window"
     */
    func display() -> String {
        var pointer : Int = self.numberPointer
        
        if self.numberPointer >= self.inputs.count {
            // The pointer is beyond the end of the inputs because the user
            // just entered an operand, so we use the previous pointer instead
            // to return the *last* number that was input. As soon as the user
            // hits a number, this condition will no longer be true.
            pointer = self.previousNumberPointer
        }
        
        // Find the end of the run
        var currentDisplay = ""
        for var i = pointer; i < self.inputs.count; i++ {
            if !(self.inputs[i] == "." || self.stringToNumber(self.inputs[i]) != nil) {
                break
            } else {
                currentDisplay += self.inputs[i]
            }
        }

        return currentDisplay
    }
    
    /**
     * Clear the display, or if the display is cleared, then the entire set of inputs
     * and reset the calculator
     */
    func clear() {
        // Check and see whether the display was already cleared. If so, we want to reset
        // the entire calculator.
        if self.numberPointer >= self.inputs.count {
            print("Resetting the calculator")

            self.reset()
        } else {
            print("Clearing the display")
            
            self.inputs = Array(self.inputs[0..<self.numberPointer])
            
            self.numberPointer = self.inputs.count
        }
    }
    
    /**
     * Reset the calculator
     */
    func reset() {
        self.inputs = []
        self.numberPointer = 0
        self.previousNumberPointer = 0
    }
    
    /**
    * Convert the specified string to a double
    */
    private func stringToNumber(str : String) -> NSNumber? {
        return NSNumberFormatter().numberFromString(str);
    }
}
