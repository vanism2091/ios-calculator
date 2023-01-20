//
//  Extensions.swift
//  CalculatorTests
//
//  Created by sei_dev on 1/19/23.
//

import Foundation
@testable import Calculator

extension Formula: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.operands == rhs.operands && lhs.operators == rhs.operators
    }
}

extension CalculatorItemQueue where Element: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.values == rhs.values
    }
}
