//
//  Formula.swift
//  Calculator
//
//  Created by sei on 2023/01/17.
//

import Foundation

struct Formula {
    var operands = CalculatorItemQueue()
    var operators = CalculatorItemQueue()

    mutating func result() throws -> Double {
        guard let operand1 = operands.dequeue() as? Double,
              let operand2 = operands.dequeue() as? Double,
              let operator1 = operators.dequeue() as? Operator else {
            return 0.0
        }
        return operator1.calculate(lhs: operand1, rhs: operand2)
    }
}
