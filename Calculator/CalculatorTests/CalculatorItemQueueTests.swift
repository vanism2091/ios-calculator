//
//  CalculatorItemQueueTests.swift
//  CalculatorTests
//
//  Created by sei on 2023/01/17.
//

import XCTest
@testable import Calculator

final class CalculatorItemQueueTests: XCTestCase {

    var sut: CalculatorItemQueue!

    override func setUpWithError() throws {
        sut = CalculatorItemQueue()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_초기화했을때_isEmpty_true() throws {
        XCTAssertTrue(sut.isEmpty)
    }

    func test_operator를_넣으면_empty가_아니다() throws {
        let addOperator = Operator.add

        sut.enqueue(item: addOperator)

        XCTAssertFalse(sut.isEmpty)
    }

    func test_Operator_add를_enqueue하고_dequeue하면_isEmpty는_true이다() throws {
        let addOperator = Operator.add

        sut.enqueue(item: addOperator)

        _ = sut.dequeue()

        XCTAssertTrue(sut.isEmpty)
    }

    func test_빈_queue에서_deque하면_nil이_반환된다() throws {
        XCTAssertNil(sut.dequeue())
    }

    func test_Queue에_3개_enqueue_후_removeAll하면_isEmpty는_true() throws {
        let addOperator1 = Operator.add
        let addOperator2 = Operator.add
        let addOperator3 = Operator.add

        sut.enqueue(item: addOperator1)
        sut.enqueue(item: addOperator2)
        sut.enqueue(item: addOperator3)

        sut.removeAll()

        XCTAssertTrue(sut.isEmpty)
    }

    func test_Queue에_Double도_넣을_수_있음() throws {
        let doubleItem1 = 123.456

        sut.enqueue(item: doubleItem1)

        XCTAssertFalse(sut.isEmpty)
    }

    func test_Operator_subtract를_enqueue하면_isEmpty는_false이다() {
        let subtractOperator = Operator.subtract

        sut.enqueue(item: subtractOperator)

        XCTAssertFalse(sut.isEmpty)
    }

    func test_Operator_multiply를_enqueue하면_isEmpty는_false이다() {
        let multiplyOperator = Operator.multiply

        sut.enqueue(item: multiplyOperator)

        XCTAssertFalse(sut.isEmpty)
    }

    func test_Operator_divide를_enqueue하면_isEmpty는_false이다() {
        let divideOperator = Operator.divide

        sut.enqueue(item: divideOperator)

        XCTAssertFalse(sut.isEmpty)
    }
}
