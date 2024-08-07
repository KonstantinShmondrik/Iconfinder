//
//  HomeViewController.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import UIKit

class HomeViewController: UIViewController {

    private var iconsList: IconsDTO?
    private let userRatesApiFactory = ApiFactory.makeIconsSeacherApi()
    private let iconsModelFactory = IconsModelFactory()
    var error: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        getIconsList(qwery: "arrow")
    }

    func getIconsList(qwery: String?) {
        if let qwery {
            self.userRatesApiFactory.getIcons(query: qwery) { data, errorMessage in
                guard let data else {
                    self.error = errorMessage ?? Texts.ErrorMessage.general
                    print("ERROR: \(self.error)")
                    return
                }
                self.iconsList = data
                print(self.iconsModelFactory.makeModels(from: data))
            }
        }
    }
}

