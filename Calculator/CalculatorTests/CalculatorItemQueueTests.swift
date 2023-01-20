//
//  CalculatorItemQueueTests.swift
//  CalculatorTests
//
//  Created by sei on 2023/01/17.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {

    var doubleSut: CalculatorItemQueue<Double>!
    var operatorSut: CalculatorItemQueue<Operator>!

    override func setUpWithError() throws {
        doubleSut = CalculatorItemQueue<Double>(items: [])
        operatorSut = CalculatorItemQueue<Operator>(items: [])
    }

    override func tearDownWithError() throws {
        doubleSut = nil
        operatorSut = nil
    }

    func test_초기화했을때_isEmpty_true() throws {
        XCTAssertTrue(doubleSut.isEmpty)
    }

    func test_operator를_넣으면_empty가_아니다() throws {
        let addOperator = Operator.add

        operatorSut.enqueue(item: addOperator)

        XCTAssertFalse(operatorSut.isEmpty)
    }

    func test_Operator_add를_enqueue하고_dequeue하면_isEmpty는_true이다() throws {
        let addOperator = Operator.add

        operatorSut.enqueue(item: addOperator)

        _ = operatorSut.dequeue()

        XCTAssertTrue(operatorSut.isEmpty)
    }

    func test_빈_queue에서_deque하면_nil이_반환된다() throws {
        XCTAssertNil(operatorSut.dequeue())
    }

    func test_Queue에_Double도_넣을_수_있음() throws {
        let doubleItem1 = 123.456

        doubleSut.enqueue(item: doubleItem1)

        XCTAssertFalse(doubleSut.isEmpty)
    }

    func test_Operator_subtract를_enqueue하면_isEmpty는_false이다() {
        let subtractOperator = Operator.subtract

        operatorSut.enqueue(item: subtractOperator)

        XCTAssertFalse(operatorSut.isEmpty)
    }

}
