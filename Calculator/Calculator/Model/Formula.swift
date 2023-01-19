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

        let pairs = zip(operands.dropFirst(), operators)
        guard false == pairs.contains(where: { pair in (0.0, Operator.divide) == pair }) else {
            throw FormulaError.dividedByZero
        }

        let result = pairs.reduce(operands[0]) { (partialResult, pair) in
            let (currentOperand, currentOperator) = pair
            return currentOperator.calculate(lhs: partialResult, rhs: currentOperand)
        }
        return result
    }
}
