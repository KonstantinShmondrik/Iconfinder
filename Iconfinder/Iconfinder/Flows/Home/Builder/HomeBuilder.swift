//
//  HomeBuilder.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 07.08.2024.
//

import UIKit

// MARK: - HomeBuilder

class HomeBuilder {

    static func build() -> (UIViewController & HomeViewInput) {
        let presenter = HomePresenter()
        let viewController = HomeViewController(presenter: presenter)

        presenter.viewInput = viewController
        return viewController
    }
}
