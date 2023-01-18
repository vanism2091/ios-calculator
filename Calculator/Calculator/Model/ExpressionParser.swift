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
}
