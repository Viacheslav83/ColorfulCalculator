//
//  DifferentEnums.swift
//  CalculatorV2
//
//  Created by Viacheslav Markov on 19.09.2020.
//  Copyright © 2020 Viachslav Markov. All rights reserved.
//

import Foundation

enum Operads: String {
    
    case plus = "+"
    case minus = "-"
    case multiple = "*"
    case division = "/"
    
    func usedOperation(numOne: Double, numTwo: Double) -> Double {
        switch self {
        case .plus:
            return numOne + numTwo
        case .minus:
            return numOne - numTwo
        case .multiple:
            return numOne * numTwo
        case .division:
            return numOne / numTwo
        }
    }
}

enum OperationError: Error, LocalizedError {
    case divideByZero
    case sqrtOfNegative
    case trigonometricError
    
    var errorDescription: String? {
        switch self {
        case .divideByZero:
            return "ERROR: cannot be divided by 0"
        case .sqrtOfNegative:
            return "ERROR: you cannot get the root of a negative number"
        case .trigonometricError:
            return "ERROR: function not defined, you entered the wrong angle"
        }
    }
}


