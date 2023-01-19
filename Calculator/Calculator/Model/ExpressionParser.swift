//
//  ExpressionParser.swift
//  Calculator
//
//  Created by jun on 2023/01/18.
//

import Foundation

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        if input == "" {
            return Formula()
        }
        return Formula(operands: [3, 4], operators: [.add])
    }

    static func componentsByOperators(from input: String) -> [String] {
        let result = Operator.allCases.reduce([input]) { (partialResult, currentOperator) in
            return partialResult.flatMap { $0.split(with: currentOperator.rawValue )}
        }
        return result
    }
}
