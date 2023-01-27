//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    private enum Constant {
        static let zero = "0"
        static let doubleZero = "00"
        static let dot = "."
        static let allClear = "AC"
        static let clearEntry = "CE"
        static let NotANumber = "NaN"
    }

    @IBOutlet private weak var operatorLabel: UILabel!
    @IBOutlet private weak var entryNumberLabel: UILabel!
    @IBOutlet private weak var calculationHistoryScrollView: UIScrollView!
    @IBOutlet private weak var calculationHistoryContentView: UIStackView!

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 20
        return formatter
    }()

    private let maxDigitLength = 20
    private var isDisplayNumberZeroOnly: Bool {
        displayNumber == Constant.zero
    }
    private var hasDisplayNumberDecimalPlaces: Bool {
        displayNumber.contains(Constant.dot)
    }
    private var formulaString = ""
    private var isNumberInTyping = false
    private var displayNumber: String {
        get { entryNumberLabel.text?.replacingOccurrences(of: ",", with: "") ?? "0" }
        set { entryNumberLabel.text = newValue }
    }
    private var displayOperator: String {
        get { operatorLabel.text ?? "" }
        set { operatorLabel.text = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func digitDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle, displayNumber.count < maxDigitLength else { return }
        if isNumberInTyping {
            displayNumber += digit
        } else {
            displayNumber = digit
            isNumberInTyping = true
        }
    }

    @IBAction private func arithmeticOperatorDidTap(_ sender: UIButton) {
        if displayNumber == Constant.NotANumber {
            displayNumber = "0"
        }
        guard let buttonTitle = sender.currentTitle else { return }
        if isNumberInTyping || false == isDisplayNumberZeroOnly {
            addCalculationHistory()
        }
        displayOperator = buttonTitle
        clearEntry()
    }

    @IBAction private func equalsDidTap(_ sender: UIButton) {
        guard false == displayOperator.isEmpty else { return }
        addCalculationHistory()
        let result = calculationResult(from: formulaString)
        displayNumber = result
        clearOperatorAndFormulaString()
        isNumberInTyping = false
    }

    @IBAction private func clearDidTap(_ sender: UIButton) {
        switch sender.currentTitle {
        case Constant.clearEntry:
            clearEntry()
        case Constant.allClear:
            clearAll()
        default:
            return
        }
    }

    @IBAction private func signToggleDidTap(_ sender: UIButton) {
        guard nil != sender.currentTitle,
              false == isDisplayNumberZeroOnly,
              let number = Double(displayNumber) else { return }
        displayNumber = parse(String(number * -1))
    }

    @IBAction private func zeroOrPointDidTap(_ sender: UIButton) {
        guard let buttonTitle = sender.currentTitle,
              displayNumber.count < maxDigitLength else { return }

        switch buttonTitle {
        case Constant.zero, Constant.doubleZero:
            if isDisplayNumberZeroOnly { return }
            let suffix = (displayNumber + buttonTitle).count > maxDigitLength ? Constant.zero : buttonTitle
            displayNumber += suffix
        case Constant.dot:
            guard false == hasDisplayNumberDecimalPlaces else { return }
            displayNumber += buttonTitle
            isNumberInTyping = true
        default:
            return
        }
    }
}

extension CalculatorViewController {
    // MARK: CalculationResult
    private func calculationResult(from formula: String) -> String {
        let result = ExpressionParser.parse(from: formula).result()
        switch result {
        case .success(let res):
            return parse(String(res))
        case .failure(let error):
            return error.description
        }
    }

    // MARK: Parse - numberFormat
    private func parse(_ value: String) -> String {
        let removedComma = value.replacingOccurrences(of: ",", with: "")
        let nsNumber = numberFormatter.number(from: removedComma)
        return (numberFormatter.string(for: nsNumber) ?? "0")
    }

    // MARK: Add History
    private func addCalculationHistory() {
        let currOperator = formulaString.isEmpty ? "" : displayOperator
        appendHistoryStackView(operator: currOperator)
        formulaString += "\(currOperator)\(displayNumber)"
    }

    private func appendHistoryStackView(operator: String?) {
        let parsedNumber = parse(displayNumber)
        let stackView = HistoryStackView(operator: `operator`, operand: parsedNumber)
        calculationHistoryContentView.addArrangedSubview(stackView)

        view.layoutIfNeeded()
        calculationHistoryScrollView.scrollToBottom()
    }

    // MARK: Clear
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
