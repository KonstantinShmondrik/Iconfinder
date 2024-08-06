//
//  IconsSeacherApy.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 06.08.2024.
//

import Foundation

// MARK: - UserRatesApi

enum IconsSeacherApi {
    case getList(String)
}

// MARK: EndPointType

extension IconsSeacherApi: EndPointType {

    var path: String { "v4/icons/search" }
    
    var parameters: Parameters? {
        switch self {
        case .getList(let query):
            return [
                "query" : query,
                "count" : 10
            ]
        }
    }

    var httpMethod: HTTPMethod { .get }

    var task: HTTPTask {
        .requestParametersAndHeaders(
            bodyParameters: nil,
            bodyEncoding: .urlEncoding,
            urlParameters: parameters,
            additionHeaders: headers
        )
    }
    
    var headers: HTTPHeaders? {
        [HttpConstants.authorization : Constants.testAuth.testAuth]
    }
}
