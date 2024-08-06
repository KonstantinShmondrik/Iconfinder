//
//  JSONParameterEncoder.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import Foundation

// MARK: - JSONParameterEncoder

struct JSONParameterEncoder: ParameterEncoder {

    // MARK: - ParameterEncoder protocol implementation

    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: HttpConstants.contentType) == nil {
                urlRequest.setValue(
                    HttpConstants.jsonContent,
                    forHTTPHeaderField: HttpConstants.contentType
                )
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
