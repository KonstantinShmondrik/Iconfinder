//
//  IconfinderUITests.swift
//  IconfinderUITests
//
//  Created by Константин Шмондрик on 05.08.2024.
//

import XCTest

final class IconfinderUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        try? super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(iOS 14.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    func testSearchIcons() {
        let app = XCUIApplication()
        app.launch()

        let homeViewController = app.otherElements["homeViewController"].firstMatch
        let searchFTextField = app.textFields["searchFTextField"].firstMatch
        let searchButton = app.buttons["searchButton"].firstMatch

        searchFTextField.tap()
        searchFTextField.typeText("Arrow")

        searchButton.tap()
        XCTAssert(homeViewController.waitForExistence(timeout: 5))
    }

    func testErrortSearchIcons() {
        let app = XCUIApplication()
        app.launch()

        let homeViewController = app.otherElements["homeViewController"].firstMatch
        let searchFTextField = app.textFields["searchFTextField"].firstMatch
        let searchButton = app.buttons["searchButton"].firstMatch
        let alert = app.alerts.firstMatch

        searchFTextField.tap()
        searchFTextField.typeText("Arrow 3")

        searchButton.tap()
        XCTAssert(alert.waitForExistence(timeout: 5))

        alert.buttons.firstMatch.tap()
        XCTAssert(homeViewController.waitForExistence(timeout: 2))

    }
}
