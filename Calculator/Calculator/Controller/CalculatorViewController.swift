//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var entryNumberLabel: UILabel!
    @IBOutlet weak var calculationHistoryScrollView: UIScrollView!
    @IBOutlet weak var calculationHistoryContentView: UIStackView!

    let maxDigitLength = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCurrentDisplay()
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle,
              let label = entryNumberLabel.text else { return }
        if entryNumberLabel.text == "0" {
            entryNumberLabel.text = digit
        } else if label.count < maxDigitLength {
            entryNumberLabel.text?.append(digit)
        }
    }

    @IBAction func arithmeticOperatorDidTap(_ sender: UIButton) {
        if let currentOperator = operatorLabel.text,
           let currentNumber = entryNumberLabel.text {
            buildCalculationHistoryStack(operator: currentOperator, number: currentNumber)
        }
        operatorLabel.text = sender.currentTitle
        initializeNumberLabel()
    }

    @IBAction func equalsDidTap(_ sender: UIButton) {
        print(sender.currentTitle ?? "==")
    }

    @IBAction func clearDidTap(_ sender: UIButton) {
        initializeCurrentDisplay()
        if sender.currentTitle == "AC" {
            // clear history
        }
    }

    @IBAction func signToggleDidTap(_ sender: UIButton) {
        guard nil != sender.currentTitle,
              let currentNumberString = entryNumberLabel.text,
              let currentNumber = Double(currentNumberString) else { return }
        entryNumberLabel.text = String(currentNumber * -1)
    }

    @IBAction func zeroOrPointDidTap(_ sender: UIButton) {
        guard let buttonName = sender.currentTitle,
              let currentNumber = entryNumberLabel.text,
              currentNumber.count < maxDigitLength else { return }

        switch buttonName {
        case "0", "00":
            guard entryNumberLabel.text != "0" else { return }
            entryNumberLabel.text?.append(buttonName)
            if let number = entryNumberLabel.text, number.count > maxDigitLength {
                entryNumberLabel.text?.removeLast()
            }
        case ".":
            guard false == entryNumberLabel.text?.contains(".") else { return }
            entryNumberLabel.text?.append(buttonName)
        default:
            return
        }
    }

    private func initializeCurrentDisplay() {
        operatorLabel.text = nil
        initializeNumberLabel()
    }

    private func initializeNumberLabel() {
        entryNumberLabel.text = "0"
    }

    private func buildCalculationHistoryStack(operator oper: String?, number: String) {
        let stackView = UIStackView()
        stackView.spacing = 8
        let operatorLabel = buildDisplayLabel(text: oper)
        let numberLabel = buildDisplayLabel(text: number)

        stackView.addArrangedSubview(operatorLabel)
        stackView.addArrangedSubview(numberLabel)

        calculationHistoryContentView.addArrangedSubview(stackView)

        view.layoutIfNeeded()
        calculationHistoryScrollView.scrollToBottom()
    }

    private func buildDisplayLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        return label
    }
}
