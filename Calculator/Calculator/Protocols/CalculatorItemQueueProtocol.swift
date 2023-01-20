//
//  CalculatorItemQueueProtocol.swift
//  Calculator
//
//  Created by sei_dev on 1/20/23.
//

import Foundation

protocol CalculatorItemQueueProtocol {
    var isEmpty: Bool { get }
    var count: Int { get }

    associatedtype Element: CalculateItem
    var values: [Element] { get }

    init(items: [Element])
    mutating func enqueue(item: Element)
    mutating func dequeue() -> Element?
}
