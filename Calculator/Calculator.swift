//
//  Calculator.swift
//  Calculator
//
//  Created by Andrew Munsell on 10/6/15.
//  Copyright © 2015 Andrew Munsell. All rights reserved.
//

import Foundation

enum CalculatorError : ErrorType {
    case InvalidOperand
    case IllegalArgument
    case DivideByZero
}

class Calculator {
    /**
     * Initialize a new calculator and begin the loop to request input
     */
    init() {
        do {
            try self.run()
        } catch CalculatorError.IllegalArgument {
            print("An invalid argument was specified.")
        } catch CalculatorError.InvalidOperand {
            print("An invalid operand was specified.")
        } catch CalculatorError.DivideByZero {
            print("Cannot divide by zero.")
        } catch {
            print("An error occurred when performing a calculation.")
        }
    }
    
    /**
     * Run the calculation loop
     */
    private func run() throws {
        var inputs = [String]()

        var calculating : Bool = true
        var multiOperand : String?
        
        print("Calculator:")
        print("Enter a single operator (+, -, /, *, %, **) or operand  per line.")
        print("To calculate a function, enter one number per line, then the function name (fact, count, avg).")
        print("")

        repeat {
            print(" ", terminator: ">")
            let input = self.getInput()
            
            if self.stringToNumber(input) == nil {
                switch input {
                case "add", "sub", "div", "mul", "mod", "exp", "+", "-", "*", "/", "%", "**":
                    inputs.append(input)
                case "":
                    calculating = false
                default:
                    multiOperand = input
                    calculating = false
                }

            } else {
                inputs.append(input)
            }
        } while calculating
        
        var result : Double
        
        // Perform the calculations
        if multiOperand != nil {
            result = try self.calculateMultiOperand(multiOperand!, inputs: inputs)
        } else {
            result = try self.calculate(inputs)
        }
        
        print("Result: \(result)")
    }
    
    /**
     * Calculate a multi-operand operation
     */
    private func calculateMultiOperand(operand : String, inputs : [String]) throws -> Double {
        var result : Double
        
        switch operand {
        case "avg":
            var sum = 0.0
            
            for number in inputs {
                let num = self.stringToNumber(number)
                if num == nil {
                    throw CalculatorError.IllegalArgument
                }
                
                sum += num!.doubleValue
            }
            
            result = sum / Double(inputs.count)
        case "count":
            result = Double(inputs.count)
        case "fact":
            if inputs.count != 1 {
                throw CalculatorError.IllegalArgument
            }
            
            var num = self.stringToNumber(inputs[0])!.integerValue
            var factorial = num
            
            while --num > 0 {
                factorial *= num
            }
            
            result = Double(factorial)
        default:
            throw CalculatorError.InvalidOperand
        }
        
        return result
    }
    
    /**
     * Calculate a normal calculation
     */
    private func calculate(inputs : [String]) throws -> Double {
        var result = self.stringToNumber(inputs[0])!.doubleValue
        var currentOperand : String?
        
        for var i = 1; i < inputs.count; i++ {
            if self.stringToNumber(inputs[i]) == nil {
                currentOperand = inputs[i]
            } else if currentOperand != nil {
                let current = self.stringToNumber(inputs[i])!.doubleValue

                // Perform the operation since we have an operand queued
                switch currentOperand! {
                case "add", "+":
                    result += current
                case "sub", "-":
                    result -= current
                case "mul", "*":
                    result *= current
                case "div", "/":
                    if current == 0.0 {
                        throw CalculatorError.DivideByZero
                    }

                    result /= current
                case "mod", "%":
                    result %= current
                case "exp", "**":
                    result = pow(result, current)
                default:
                    throw CalculatorError.InvalidOperand
                }

                currentOperand = nil
            } else {
                // Something was wrong, such as two numbers were entered sequentially
                throw CalculatorError.IllegalArgument
            }
        }
        
        return result
    }
    
    /**
     * Convert the specified string to a double
     */
    private func stringToNumber(str : String) -> NSNumber? {
        return NSNumberFormatter().numberFromString(str);
    }
    
    /**
     * Read a line of input from the console
     */
    private func getInput() -> String {
        let keyboard = NSFileHandle.fileHandleWithStandardInput()
        let inputData = keyboard.availableData
        let result = NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
        
        return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}