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

    var description: String {
        switch self {
        case .dividedByZero:
            return "NaN"
        case .wrongFormula:
            return "올바르지 않은 식"
        }
    }
}

struct Formula {
    var operands: CalculatorItemQueue<Double>
    var operators: CalculatorItemQueue<Operator>

    init(operands: [Double] = [], operators: [Operator] = []) {
        self.operands = CalculatorItemQueue(items: operands)
        self.operators = CalculatorItemQueue(items: operators)
    }

    func result() -> Result<Double, FormulaError> {
        guard operands.count == operators.count + 1 else {
            return .failure(.wrongFormula)
        }

        let pairs = zip(operands.values.dropFirst(), operators.values)
        guard false == pairs.contains(where: { pair in (0.0, Operator.divide) == pair }) else {
            return .failure(.dividedByZero)
        }

        let result = pairs.reduce(operands.values[0]) { (partialResult, pair) in
            let (operand, `operator`) = pair
            return `operator`.calculate(lhs: partialResult, rhs: operand)
        }
        return .success(result)
    }
}
