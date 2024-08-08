//
//  PaddedTextField.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 09.08.2024.
//

import UIKit

class PaddedTextField: UITextField {

    var textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return correctedRect(bounds.inset(by: textPadding))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return correctedRect(bounds.inset(by: textPadding))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return correctedRect(bounds.inset(by: textPadding))
    }

    private func correctedRect(_ rect: CGRect) -> CGRect {
        let minX = max(rect.origin.x, 0)
        let minY = max(rect.origin.y, 0)
        let width = max(rect.width, 0)
        let height = max(rect.height, 0)

        return CGRect(x: minX, y: minY, width: width, height: height)
    }
}
