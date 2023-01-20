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
    var operands: CalculatorItemQueue<Double>
    var operators: CalculatorItemQueue<Operator>

    init(operands: [Double] = [], operators: [Operator] = []) {
        self.operands = CalculatorItemQueue(items: operands)
        self.operators = CalculatorItemQueue(items: operators)
    }

    func result() throws -> Double {
        guard operands.count == operators.count + 1 else {
            throw FormulaError.wrongFormula
        }

        let pairs = zip(operands.items.dropFirst(), operators.items)
        guard false == pairs.contains(where: { pair in (0.0, Operator.divide) == pair }) else {
            throw FormulaError.dividedByZero
        }

        let result = pairs.reduce(operands.items[0]) { (partialResult, pair) in
            let (currentOperand, currentOperator) = pair
            return currentOperator.calculate(lhs: partialResult, rhs: currentOperand)
        }
        return result
    }
}
