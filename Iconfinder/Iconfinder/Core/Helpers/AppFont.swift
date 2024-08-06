//
//  AppFont.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import UIKit

struct AppFont {

    enum Style {
        /// 12, regular
        static let subtitle = UIFont.systemFont(ofSize: 12, weight: .regular)
        /// 16, regular
        static let regularText = UIFont.systemFont(ofSize: 16, weight: .regular)
        /// 16, bold
        static let blockTitle = UIFont.systemFont(ofSize: 16, weight: .bold)
        /// 20, bold
        static let title = UIFont.systemFont(ofSize: 20, weight: .bold)
        /// 28, bold
        static let pageLargeTitle = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
}
