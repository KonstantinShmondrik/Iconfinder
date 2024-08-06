//
//  UIView+addSubviews.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import UIKit

extension UIView {

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(self.addSubview)
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
