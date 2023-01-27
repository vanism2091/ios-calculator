//
//  UIStackView+Extension.swift
//  Calculator
//
//  Created by sei_dev on 1/25/23.
//

import UIKit

extension UIStackView {
    func removeAllHistorySubviews() {
        arrangedSubviews.dropFirst().forEach { history in
            history.removeFromSuperview()
        }
    }
}