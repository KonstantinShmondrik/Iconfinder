//
//  HomeViewController.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    let presenter: HomeViewOutput
    var models: [IconsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        presenter.getIconsList(qwery: "arrow")
    }


    // MARK: - Construction

    init(presenter: HomeViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension HomeViewController: HomeViewInput {

    func reloadData() {
        print(models)
    }
}

