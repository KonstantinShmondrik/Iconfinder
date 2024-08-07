//
//  HomeRequestFactoryProtocol.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 06.08.2024.
//

import Foundation

// MARK: - HomeRequestFactoryProtocol

protocol HomeRequestFactoryProtocol {

    // MARK: - Properties

    var delegate: (AbstractRequestFactory<IconsSeacherApi>)? { get }

    // MARK: - Functions

    func getIcons(query: String, completion: @escaping (_ response: IconsDTO?, _ error: String?) -> Void)
}

// MARK: - HomeRequestFactoryProtocol extension

extension HomeRequestFactoryProtocol {

    // MARK: - Functions

    func getIcons(query: String, completion: @escaping (_ response: IconsDTO?, _ error: String?) -> Void) {
        delegate?.getResponse(
            type: IconsDTO.self,
            endPoint: .getList(query),
            completion: completion
        )
    }
}

// MARK: - HomeRequestFactory

final class HomeRequestFactory: HomeRequestFactoryProtocol {

    // MARK: - Properties

    let delegate: (AbstractRequestFactory<IconsSeacherApi>)?

    // MARK: - Construction

    init() {
        delegate = AbstractRequestFactory<IconsSeacherApi>()
    }
}
