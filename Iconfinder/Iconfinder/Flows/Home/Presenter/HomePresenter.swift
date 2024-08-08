//
//  HomePresenter.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 07.08.2024.
//

import UIKit

final class HomePresenter {

    // MARK: - Properties

    weak var viewInput: HomeViewInput?

    // MARK: - Private properties

    private var iconsList: IconsDTO?
    private let userRatesApiFactory = ApiFactory.makeIconsSeacherApi()
    private let iconsModelFactory = IconsModelFactory()

    private var error: String = ""

    // MARK: - Private functions


}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {

    func getIconsList(qwery: String?) {
        if let qwery {
            self.userRatesApiFactory.getIcons(query: qwery) { data, errorMessage in
                guard let data else {
                    self.error = errorMessage ?? Texts.ErrorMessage.general
                    print("ERROR: \(self.error)")
                    return
                }
                self.iconsList = data
                self.viewInput?.models = self.iconsModelFactory.makeModels(from: data)
                self.viewInput?.reloadData()
            }
        }
    }

    func viewDidSelectEntity(entity: IconsModel) {
        print(entity)
    }
}
