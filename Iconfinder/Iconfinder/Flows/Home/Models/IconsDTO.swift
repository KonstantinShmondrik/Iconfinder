//
//  IconsDTO.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 06.08.2024.
//

import Foundation

// MARK: - IconsDTO
struct IconsDTO: Codable {

    let totalCount: Int
    let icons: [Icon]?

    enum CodingKeys: String, CodingKey {

        case totalCount = "total_count"
        case icons
    }
}

// MARK: - Icon
struct Icon: Codable {
    let iconID: Int?
    let tags: [String]?
    let publishedAt: String?
    let isPremium: Bool?
    let type: TypeEnum?
    let containers: [Container]?
    let rasterSizes: [RasterSize]?
    let styles, categories: [Category]?
    let isIconGlyph: Bool?

    enum CodingKeys: String, CodingKey {
        case iconID = "icon_id"
        case tags
        case publishedAt = "published_at"
        case isPremium = "is_premium"
        case type, containers
        case rasterSizes = "raster_sizes"
        case styles, categories
        case isIconGlyph = "is_icon_glyph"
    }
}

// MARK: - Category
struct Category: Codable {
    let identifier, name: String?
}

// MARK: - Container
struct Container: Codable {
    let format: ContainerFormat?
    let downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case format
        case downloadURL = "download_url"
    }
}

enum ContainerFormat: String, Codable {
    case icns = "icns"
    case ico = "ico"
}

// MARK: - RasterSize
struct RasterSize: Codable {
    let formats: [FormatElement]?
    let size, sizeWidth, sizeHeight: Int?

    enum CodingKeys: String, CodingKey {
        case formats, size
        case sizeWidth = "size_width"
        case sizeHeight = "size_height"
    }
}

// MARK: - FormatElement
struct FormatElement: Codable {
    let format: FormatFormat?
    let previewURL: String?
    let downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case format
        case previewURL = "preview_url"
        case downloadURL = "download_url"
    }
}

enum FormatFormat: String, Codable {
    case png = "png"
}

enum TypeEnum: String, Codable {
    case raster = "raster"
}
