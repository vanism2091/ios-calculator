//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by jun on 2023/01/17.
//

import Foundation

struct CalculatorItemQueue<Element: CalculateItem>: CalculatorItemQueueProtocol {
    private var items: [Element] = []

    var isEmpty: Bool {
        items.isEmpty
    }

    var count: Int {
        items.count
    }

    var values: [Element] {
        items
    }

    init(items: [Element]) {
        items.forEach { element in
            self.enqueue(item: element)
        }
    }

    mutating func enqueue(item: Element) {
        items.append(item)
    }

    mutating func dequeue() -> Element? {
        guard false == isEmpty else {
            return nil
        }
        return items.removeFirst()
    }
}
