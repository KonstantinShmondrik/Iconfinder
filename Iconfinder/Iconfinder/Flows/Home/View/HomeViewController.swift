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

    private let searchFTextField = PaddedTextField()
    private let searchButton = UIButton(type: .system)
    private let tableView = UITableView()

    private var query = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setLayoutConstraints()
        stylize()
        setActions()
    }


    // MARK: - Construction

    init(presenter: HomeViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Function

   private func addSubviews() {
       view.addSubviews([searchFTextField, searchButton, tableView])
    }

    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()

        searchFTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            searchFTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchFTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            searchFTextField.heightAnchor.constraint(equalToConstant: 44)
        ]

        searchButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            searchButton.centerYAnchor.constraint(equalTo: searchFTextField.centerYAnchor),
            searchButton.leftAnchor.constraint(equalTo: searchFTextField.rightAnchor, constant: 2),
            searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 44),
            searchButton.heightAnchor.constraint(equalToConstant: 44)
        ]

        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 24),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        view.backgroundColor = AppColor.backgroundMain

        searchFTextField.layer.borderColor = AppColor.line.cgColor
        searchFTextField.clipsToBounds = true
        searchFTextField.layer.cornerRadius = 8
        searchFTextField.backgroundColor = AppColor.backgroundMinor
        searchFTextField.textColor = AppColor.textMain
        searchFTextField.placeholder = "Поиск"
        searchFTextField.tintColor = AppColor.textMain
        searchFTextField.textAlignment = .left
        searchFTextField.font = AppFont.Style.regularText

        let image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
        searchButton.backgroundColor = AppColor.buttonColor
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 8
        searchButton.tintColor = AppColor.textMinor
        searchButton.setImage(image, for: .normal)
        searchButton.imageView?.contentMode = .scaleAspectFit

        if let imageView = searchButton.imageView {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 40),
                imageView.heightAnchor.constraint(equalToConstant: 40)
            ])
        }
    }

    private func setActions() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(SearchResultTableCell.self)

        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func searchAction() {
        guard let text = searchFTextField.text,
              !text.isEmpty else { return }
        hideKeyboard()
        presenter.getIconsList(qwery: text)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    // MARK: - UIScrollViewDelegate method

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 102 }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entity = models[indexPath.row]
        self.presenter.viewDidSelectEntity(entity: entity)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchResultTableCell = tableView.cell(forRowAt: indexPath) else { return UITableViewCell() }
        cell.configure(with: models[indexPath.row])
        return cell
    }
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {

    func reloadData() {
        tableView.reloadData()
        print(models)
    }
}

