//
//  Operator.swift
//  Calculator
//
//  Created by sei on 2023/01/17.
//

import Foundation

enum Operator: CalculateItem {
    case add
    case subtract
    case multiply
    case divide
}

extension Operator: CustomStringConvertible {
    var description: String {
        switch self {
        case .add:
            return "+"
        case .subtract:
            return "−"
        case .multiply:
            return "×"
        case .divide:
            return "÷"
        }
    }
}
