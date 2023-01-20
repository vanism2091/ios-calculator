//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by jun on 2023/01/17.
//

import Foundation

struct CalculatorItemQueue<Element: CalculateItem> {
    private(set) var items: [Element] = []

    var isEmpty: Bool {
        items.isEmpty
    }

    var count: Int {
        items.count
    }

    mutating func enqueue(item: Element) {
        items.append(item)
    }

    mutating func dequeue() -> Element? {
        guard false == items.isEmpty else {
            return nil
        }
        return items.removeFirst()
    }

    mutating func removeAll() {
        items.removeAll()
    }
}
