//
//  HistoryLabel.swift
//  Calculator
//
//  Created by sei_dev on 1/26/23.
//

import UIKit

final class HistoryLabel: UILabel {
    init(value: String?) {
        super.init(frame: CGRect())
        self.textColor = .white
        self.font = .preferredFont(forTextStyle: .title3)
        self.text = value
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
