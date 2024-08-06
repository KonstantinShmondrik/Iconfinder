//
//  Constants.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import UIKit

struct Constants {

    enum Url {
        static let baseUrl = "https://api.iconfinder.com/"
    }

    enum testAuth {
        static let testAuth = HttpConstants.bearer + " " + "X0vjEUN6KRlxbp2DoUkyHeM0VOmxY91rA6BbU5j3Xu6wDodwS0McmilLPBWDUcJ1"
    }

    enum DateFormatter {
        static let dayMonthCommaHoursMinutes = "dd MMMM, HH:mm"
        static let year = "yyyy"
        static let yearMonthDay = "yyyy-MM-dd"
    }

    enum Prefix {
        static let byte = 1
        static let kilobyte = 1024
        static let megabyte = 1_048_576
    }

    enum ImageCacheParam {
        static let memoryCapacity = 50 * Prefix.megabyte
        static let diskCapacity = 50 * Prefix.megabyte
        static let maximumConnections = 5
    }

    enum Timeouts {
        static let networkRequest = 15.0
    }

    enum LimitsForRequest {
        static let itemsLimit: Int = 5000
        static let limitRequestsPerSecond: Int = 5
    }
}
