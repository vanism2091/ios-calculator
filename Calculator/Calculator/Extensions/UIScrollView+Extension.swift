//
//  UIScrollView+Extension.swift
//  Calculator
//
//  Created by sei_dev on 1/25/23.
//

import UIKit

extension UIScrollView {
  func scrollToBottom() {
    let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
    setContentOffset(bottomOffset, animated: true)
  }
}
