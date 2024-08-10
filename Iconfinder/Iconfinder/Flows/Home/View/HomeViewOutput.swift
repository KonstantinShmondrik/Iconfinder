//
//  HomeViewOutput.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 07.08.2024.
//

import Foundation

protocol HomeViewOutput: AnyObject {

    func getIconsList(qwery: String?)
    func viewDidSelectEntity(entity: IconsModel)
    func getBaseAlert(title: String, message: String?)
}
