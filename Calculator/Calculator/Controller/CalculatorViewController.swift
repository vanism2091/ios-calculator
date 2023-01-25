//
//  Calculator - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CalculatorViewController: UIViewController {

    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var currentNumberLabel: UILabel!
    @IBOutlet weak var calculationHistoryScrollView: UIScrollView!
    @IBOutlet weak var calculationHistoryContentView: UIStackView!

    private var isNumberTyped: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeCurrentDisplay()
    }

    @IBAction func digitDidTap(_ sender: UIButton) {
        guard let digit = sender.currentTitle,
              let label = currentNumberLabel.text else { return }
        if isNumberTyped {
            currentNumberLabel.text = digit
        } else if label.count < 20 {
            currentNumberLabel.text?.append(digit)
        }
        isNumberTyped = true
    }

    @IBAction func arithmeticOperatorDidTap(_ sender: UIButton) {
        if isNumberTyped,
           let currentOperator = operationLabel.text,
           let currentNumber = currentNumberLabel.text {
            buildCalculationHistoryStack(operator: currentOperator, number: currentNumber)
        }
        operationLabel.text = sender.currentTitle
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

    // TODO: - Int 말고 Double
    @IBAction func signToggleDidTap(_ sender: UIButton) {
        guard nil != sender.currentTitle,
              let currentNumberString = currentNumberLabel.text,
              let currentNumber = Int(currentNumberString) else { return }
        currentNumberLabel.text = String(currentNumber * -1)
    }

    @IBAction func zeroOrPointDidTap(_ sender: UIButton) {
        guard let buttonName = sender.currentTitle,
              let currentNumber = currentNumberLabel.text,
              currentNumber.count < 20 else { return }

        switch buttonName {
        case "0", "00":
            guard isNumberTyped else {
                isNumberTyped = true
                return
            }
            guard currentNumberLabel.text != "0" else { return }
            currentNumberLabel.text?.append(buttonName)
            if let number = currentNumberLabel.text, number.count > 20 {
                currentNumberLabel.text?.removeLast()
            }
        case ".":
            guard false == currentNumberLabel.text?.contains(".") else { return }
            currentNumberLabel.text?.append(buttonName)
        default:
            return
        }
        isNumberTyped = true
    }

    private func initializeCurrentDisplay() {
        operationLabel.text = nil
        initializeNumberLabel()
    }

    private func initializeNumberLabel() {
        currentNumberLabel.text = "0"
        isNumberTyped = false
    }

    private func buildCalculationHistoryStack(operator oper: String?, number: String) {
        let stackView = UIStackView()
        stackView.spacing = 8
        let operatorLabel = buildDisplayLabel(text: oper)
        let numberLabel = buildDisplayLabel(text: number)

        stackView.addArrangedSubview(operatorLabel)
        stackView.addArrangedSubview(numberLabel)

        calculationHistoryContentView.addArrangedSubview(stackView)
        calculationHistoryScrollView.setContentOffset(CGPoint(x: 0, y: calculationHistoryScrollView.contentSize.height - calculationHistoryScrollView.bounds.height), animated: true)
    }

    private func buildDisplayLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        return label
    }
}
