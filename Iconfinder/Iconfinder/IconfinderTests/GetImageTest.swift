//
//  GetImageTest.swift
//  IconfinderTests
//
//  Created by Константин Шмондрик on 11.08.2024.
//

import XCTest

final class GetImageTest: XCTestCase {

    let delayRequests = 1.0
    private let apiTest = "DownloadImageService"

    override func setUpWithError() throws {
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testDownloadedImage() throws {

        let service = DownloadImageService()
        let request = "downloadedImage"
        let link = "https://cdn0.iconfinder.com/data/icons/uiux-001-line/32/UI_UX_UIUX_Back-16.png"
        var response: UIImage?
        let expectation = self.expectation(description: "\(apiTest).\(request) expectation timeout")


        Timer.scheduledTimer(withTimeInterval: self.delayRequests, repeats: false) { _ in
            service.downloadedImage(from: link) { image in
                response = image
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 15)
        XCTAssertNotNil(response, "Unexpected \(apiTest).\(request) nil result")
    }
}
