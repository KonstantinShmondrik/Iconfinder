//
//  HomeViewInput.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 07.08.2024.
//

import Foundation

protocol HomeViewInput: AnyObject {

    var models: [IconsModel] { get set }
    
    func reloadData()
}
