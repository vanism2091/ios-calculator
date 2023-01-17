//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by jun on 2023/01/17.
//

import Foundation

protocol CalculateItem {}

struct CalculatorItemQueue {
    var items: [CalculateItem] = []

    var isEmpty: Bool {
        items.isEmpty
    }

    mutating func enqueue(item: CalculateItem) {
        items.append(item)
    }
}
