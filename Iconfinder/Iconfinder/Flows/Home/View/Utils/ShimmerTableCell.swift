//
//  SimmerTableCell.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 10.08.2024.
//

import UIKit

class ShimmerTableCell: UITableViewCell {

    // MARK: - Private properties

    private var contentImageView = ShimmerView()
    private var titleLabelView = ShimmerView()
    private var subtitleLabelView = ShimmerView()

    // MARK: - Construction

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        setLayoutConstraints()
        stylize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    func startAnimating() {
        contentImageView.startAnimating()
        titleLabelView.startAnimating()
        subtitleLabelView.startAnimating()
    }

    // MARK: - Private functions

    private func addSubviews() {
        self.addSubviews([contentImageView, titleLabelView, subtitleLabelView])
     }

    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()

        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            contentImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            contentImageView.widthAnchor.constraint(equalToConstant: 88),
            contentImageView.heightAnchor.constraint(equalToConstant: 88)
        ]

        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabelView.topAnchor.constraint(equalTo: contentImageView.topAnchor),
            titleLabelView.leftAnchor.constraint(equalTo: contentImageView.rightAnchor, constant: 8),
            titleLabelView.heightAnchor.constraint(equalToConstant: 40),
            titleLabelView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ]

        subtitleLabelView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            subtitleLabelView.topAnchor.constraint(equalTo: titleLabelView.bottomAnchor, constant: 2),
            subtitleLabelView.leftAnchor.constraint(equalTo: titleLabelView.leftAnchor),
            subtitleLabelView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -60),
            subtitleLabelView.heightAnchor.constraint(equalToConstant: 40)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = AppColor.backgroundMain
    }
}
