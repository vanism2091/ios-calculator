//
//  HistoryStackView.swift
//  Calculator
//
//  Created by sei_dev on 1/26/23.
//

import UIKit

final class HistoryStackView: UIStackView {
    private var operatorLabel: HistoryLabel
    private var operandLabel: HistoryLabel

    init(operator: String? = nil, operand: String) {
        self.operatorLabel = HistoryLabel(value: `operator`)
        self.operandLabel = HistoryLabel(value: operand)
        super.init(frame: CGRect())

        self.addArrangedSubview(operatorLabel)
        self.addArrangedSubview(operandLabel)
        self.spacing = 8
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
