//
//  HomeViewInput.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 07.08.2024.
//

import UIKit

protocol HomeViewInput: AnyObject {

    var models: [IconsModel] { get set }
    var isLoading: Bool { get set }

    func reloadData()
    func showAlert(title: String, message: String?, actions: [UIAlertAction]?)
}
