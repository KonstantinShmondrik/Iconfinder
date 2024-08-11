//
//  RequestIconsListTest.swift
//  IconfinderTests
//
//  Created by Константин Шмондрик on 11.08.2024.
//

import XCTest

final class RequestIconsListTest: XCTestCase {

    let delayRequests = 1.0
    private let apiTest = "HomeRequestFactory"

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testGetIconsList() throws {

        let factory = ApiFactory.makeIconsSeacherApi()
        let request = "getIcons"
        let query = "arrow"
        var response: IconsDTO?
        var error: String?
        let expectation = self.expectation(description: "\(apiTest).\(request) expectation timeout")


        Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
            factory.getIcons(query: query) { data, errorString in
                response = data
                error = errorString
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNil(error, "Unexpected \(apiTest).\(request) error \(error ?? "")")
        XCTAssertNotNil(response, "Unexpected \(apiTest).\(request) nil result")
    }
}
