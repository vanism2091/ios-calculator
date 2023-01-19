//
//  ExpressionParser.swift
//  Calculator
//
//  Created by jun on 2023/01/18.
//

import Foundation

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        let items = componentsByOperators(from: input)
        let operands = items.compactMap { Double($0) }
        let operators = items.compactMap { $0.count == 1 ? Operator(rawValue: Character($0)) : nil }
        return Formula(operands: operands, operators: operators)
    }

    static func componentsByOperators(from input: String) -> [String] {
        let result = Operator.allCases.reduce([input]) { (partialResult, currentOperator) in
            return partialResult.flatMap { $0.split(with: currentOperator.rawValue )}
        }
        return result
    }
}
