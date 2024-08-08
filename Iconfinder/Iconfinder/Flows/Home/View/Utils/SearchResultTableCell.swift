//
//  SearchResultTableCell.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 08.08.2024.
//

import UIKit

class SearchResultTableCell: UITableViewCell {

    // MARK: - Private properties

    private var contentImageView = UIImageViewAsync()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()

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

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
        [titleLabel, subtitleLabel].forEach { $0.text = nil }
    }

    // MARK: - Functions

    func configure(with cellModel: IconsModel) {
        contentImageView.downloadedImage(from: cellModel.previewURL, contentMode: .scaleAspectFit)
        titleLabel.text = cellModel.sizes
        subtitleLabel.text = cellModel.tags
    }

    // MARK: - Private functions

    private func addSubviews() {
        self.addSubviews([contentImageView, titleLabel, subtitleLabel])
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

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.topAnchor.constraint(equalTo: contentImageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentImageView.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = AppColor.backgroundMain

        titleLabel.font = AppFont.Style.regularText
        titleLabel.textAlignment = .left

        subtitleLabel.font = AppFont.Style.subtitle
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
    }
}
