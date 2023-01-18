//
//  Formula.swift
//  Calculator
//
//  Created by sei on 2023/01/17.
//

import Foundation

enum FormulaError: Error {
    case dividedByZero
    case wrongFormula
}

struct Formula {
    var operands = CalculatorItemQueue()
    var operators = CalculatorItemQueue()

    init() { }

    init(operands: [Double], operators: [Operator]) {
        operands.forEach {
            self.operands.enqueue(item: $0)
        }
        operators.forEach {
            self.operators.enqueue(item: $0)
        }
    }

    func result() throws -> Double {
        guard operands.count == operators.count + 1,
              let operands = operands.items as? [Double],
              let operators = operators.items as? [Operator] else {
            throw FormulaError.wrongFormula
        }

        let result = try zip(operands.dropFirst(), operators).reduce(operands[0]) { (partialResult, arg1) in
            let (number, `operator`) = arg1
            guard (0.0, Operator.divide) != (number, `operator`) else {
                throw FormulaError.dividedByZero
            }
            return `operator`.calculate(lhs: partialResult, rhs: number)
        }

        return result
    }
}
