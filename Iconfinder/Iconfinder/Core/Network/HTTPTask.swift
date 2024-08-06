//
//  HTTPTask.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import Foundation

typealias HTTPHeaders = [String: String]

// MARK: - HTTPTask enum

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
                           bodyEncoding: ParameterEncoding,
                           urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
}
