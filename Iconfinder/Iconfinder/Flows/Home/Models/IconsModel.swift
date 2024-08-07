//
//  IconsModel.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 07.08.2024.
//

import UIKit

struct IconsModel {

    let iconID: Int
    let tags: String
    let sizes: String
    let previewURL: String
    let downloadURL: String
}

final class IconsModelFactory {

    // MARK: - Functions

    func makeModels(from icons: IconsDTO) -> [IconsModel] {
        guard let icons = icons.icons else { return [] }
        return icons.compactMap(self.convertModel)
    }

    // MARK: - Private functions

    private func convertModel(from icon: Icon) -> IconsModel {
        let iconID = icon.iconID ?? 0

        let tags = icon.tags?
            .prefix(10)
            .map({ String($0) }).joined(separator: ", ")

        let maxSizes = icon.rasterSizes?.max(by: { $0.size ?? 0 < $1.size ?? 0 })

        let previewURL = maxSizes?.formats?
            .first(where: { $0.format == .png })?
            .previewURL

        let downloadURL = maxSizes?.formats?
            .first(where: { $0.format == .png })?
            .downloadURL

        let size = String(format: Texts.Titles.size, maxSizes?.sizeHeight ?? 0, maxSizes?.sizeWidth ?? 0 )

        return IconsModel(
            iconID: iconID,
            tags: tags ?? "",
            sizes: size,
            previewURL: previewURL ?? "",
            downloadURL: downloadURL ?? ""
        )
    }
}
