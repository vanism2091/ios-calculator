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

    func result() throws -> Double {
        guard operands.count == operators.count + 1 else {
            throw FormulaError.wrongFormula
        }

        guard let operandsArray = operands.items as? [Double],
              let operator1 = operators.items[0] as? Operator else {
            return 0.0
        }
        guard (0.0, Operator.divide) != (operandsArray[1], operator1) else {
            throw FormulaError.dividedByZero
        }
        return operator1.calculate(lhs: operandsArray[0], rhs: operandsArray[1])
    }
}
