//
//  ApiFactory.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 06.08.2024.
//

import Foundation

// MARK: - ApiFactoryProtocol

protocol ApiFactoryProtocol {

    static func makeIconsSeacherApi() -> HomeRequestFactoryProtocol
}

// MARK: - ApiFactory

final class ApiFactory: ApiFactoryProtocol {

    // MARK: - ApiFactoryProtocol implementation

    static func makeIconsSeacherApi() -> HomeRequestFactoryProtocol {
        HomeRequestFactory()
    }
}
