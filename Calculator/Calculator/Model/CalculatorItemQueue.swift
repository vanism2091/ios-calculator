//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by jun on 2023/01/17.
//

import Foundation

struct CalculatorItemQueue {
    private(set) var items: [CalculateItem] = []

    var isEmpty: Bool {
        items.isEmpty
    }

    var count: Int {
        items.count
    }

    mutating func enqueue(item: CalculateItem) {
        items.append(item)
    }

    mutating func dequeue() -> CalculateItem? {
        guard false == items.isEmpty else {
            return nil
        }
        return items.removeFirst()
    }

    mutating func removeAll() {
        items.removeAll()
    }
}
