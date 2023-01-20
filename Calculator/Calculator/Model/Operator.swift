//
//  Operator.swift
//  Calculator
//
//  Created by sei on 2023/01/17.
//

import Foundation

enum Operator: Character, CalculateItem, CaseIterable {
    case add = "+"
    case subtract = "−"
    case multiply = "×"
    case divide = "÷"

    init?(_ input: String) {
        guard input.count == 1 else { return nil }
        guard let value = Operator(rawValue: Character(input)) else { return nil }
        self = value
    }
}

extension Operator {
    func calculate(lhs: Double, rhs: Double) -> Double {
        switch self {
        case .add:
            return Self.add(lhs, rhs)
        case .subtract:
            return Self.subtract(lhs, rhs)
        case .multiply:
            return Self.multiply(lhs, rhs)
        case .divide:
            return Self.divide(lhs, rhs)
        }
    }

    private static func add(_ lhs: Double, _ rhs: Double) -> Double {
        return lhs + rhs
    }

    private static func subtract(_ lhs: Double, _ rhs: Double) -> Double {
        return lhs - rhs
    }

    private static func multiply(_ lhs: Double, _ rhs: Double) -> Double {
        return lhs * rhs
    }

    private static func divide(_ lhs: Double, _ rhs: Double) -> Double {
        return lhs / rhs
    }
}
