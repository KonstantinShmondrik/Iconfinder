//
//  UIViewController+Alert.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 09.08.2024.
//

import UIKit

extension UIViewController {

    func setAlert(title: String, message: String? = nil, actions: [UIAlertAction]? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        defer { present(alertController, animated: true) }
        guard let actions else { return }
        actions.forEach { alertController.addAction($0) }
    }
}

