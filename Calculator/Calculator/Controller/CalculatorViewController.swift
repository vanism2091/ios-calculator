//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    enum Constant {
        static let zero = "0"
        static let doubleZero = "00"
        static let dot = "."
        static let allClear = "AC"
        static let clearEntry = "CE"
    }

    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var entryNumberLabel: UILabel!
    @IBOutlet weak var calculationHistoryScrollView: UIScrollView!
    @IBOutlet weak var calculationHistoryContentView: UIStackView!

    let maxDigitLength = 20
    var isEntryNumberZeroOnly: Bool {
        entryNumberLabel.text == Constant.zero
    }
    var formulaString = ""
    var isNumberInTyping = false

    var displayNumber: String {
        get { entryNumberLabel.text ?? "0" }
        set { entryNumberLabel.text = newValue }
    }

    var displayOperator: String {
        get { operatorLabel.text ?? "" }
        set { operatorLabel.text = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle, displayNumber.count < maxDigitLength else { return }
        if isNumberInTyping {
            displayNumber += digit
        } else {
            displayNumber = digit
            isNumberInTyping = true
        }
    }

    @IBAction func arithmeticOperatorDidTap(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle else { return }
        if isNumberInTyping || false == isEntryNumberZeroOnly {
            let currOperator = formulaString.isEmpty ? "" : displayOperator
            appendCalculationHistory(operator: currOperator, number: displayNumber)
            formulaString += "\(currOperator)\(displayNumber)"
        }
        displayOperator = buttonTitle
        clearEntry()
    }

    @IBAction func equalsDidTap(_ sender: UIButton) {
        guard false == displayOperator.isEmpty else { return }

        appendCalculationHistory(operator: displayOperator, number: displayNumber)
        formulaString += "\(displayOperator)\(displayNumber)"
        let result = calculationResult(from: formulaString)
        displayNumber = result
        clearOperatorAndFormulaString()
        isNumberInTyping = false
    }

    @IBAction func clearDidTap(_ sender: UIButton) {
        switch sender.currentTitle {
        case Constant.clearEntry:
            clearEntry()
        case Constant.allClear:
            clearAll()
        default:
            return
        }
    }

    @IBAction func signToggleDidTap(_ sender: UIButton) {
        guard nil != sender.currentTitle,
              isNumberInTyping,
              let number = Double(displayNumber) else { return }
        displayNumber = String(number * -1)
    }

    @IBAction func zeroOrPointDidTap(_ sender: UIButton) {
        guard let buttonName = sender.currentTitle,
              displayNumber.count < maxDigitLength else { return }

        switch buttonName {
        case Constant.zero, Constant.doubleZero:
            if isEntryNumberZeroOnly { return }
            entryNumberLabel.text?.append(buttonName)
            if let number = entryNumberLabel.text, number.count > maxDigitLength {
                entryNumberLabel.text?.removeLast()
            }
        case Constant.dot:
            guard false == entryNumberLabel.text?.contains(Constant.dot) else { return }
            entryNumberLabel.text?.append(buttonName)
            isNumberInTyping = true
        default:
            return
        }
    }

    private func appendCalculationHistory(operator: String?, number: String) {
        let parsedNumber = String(Double(number) ?? 0)
        let stackView = HistoryStackView(operator: displayOperator, operand: parsedNumber)
        calculationHistoryContentView.addArrangedSubview(stackView)

        view.layoutIfNeeded()
        calculationHistoryScrollView.scrollToBottom()
    }
}

// MARK: Clear
extension CalculatorViewController {
    private func clearEntry() {
        displayNumber = Constant.zero
        isNumberInTyping = false
    }

    private func clearOperatorAndFormulaString() {
        displayOperator = ""
        formulaString = ""
    }

    private func clearAll() {
        clearEntry()
        clearOperatorAndFormulaString()
        calculationHistoryContentView.removeAllHistorySubviews()
    }
}

// MARK: calculationResult
extension CalculatorViewController {
    private func calculationResult(from formula: String) -> String {
        let result = ExpressionParser.parse(from: formula).result()
        switch result {
        case .success(let res):
            return String(res)
        case .failure(let error):
            return error.description
        }
    }
}
