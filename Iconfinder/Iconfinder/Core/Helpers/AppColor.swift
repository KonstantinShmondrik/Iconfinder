//
//  AppColor.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import UIKit

enum AppColor {

    private static let missingColor: UIColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

    static let line = UIColor(named: "line") ?? missingColor
    static let textMain = UIColor(named: "textMain") ?? missingColor
    static let textMinor = UIColor(named: "textMinor") ?? missingColor
    static let buttonColor = UIColor(named: "buttonColor") ?? missingColor
    static let backgroundMain = UIColor(named: "backgroundMain") ?? missingColor
    static let backgroundMinor = UIColor(named: "backgroundMinor") ?? missingColor
}
