//
//  SpeechifyUITests.swift
//  SpeechifyUITests
//
//  Created by Oladapo Oladele on 2024/11/08.
//

import XCTest

final class SpeechifyUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testContentViewLoginNavigation() throws{
        let isApp = XCUIApplication()
        isApp.launch()
        let isViewTitle = isApp.staticTexts["ContentView_Title"]
        XCTAssertTrue(isViewTitle.exists, "Content View Should Contain A Title Text")
        XCTAssertEqual(isViewTitle.label, "Speechify", "Title Text Should Display 'Speechify'")
        let isLoginButton = isApp.staticTexts["Login_Navigation"]
        XCTAssertTrue(isLoginButton.exists, "Content View Should Contain A Login Text Button")
        XCTAssertEqual(isLoginButton.label, "Login", "Text Button Should Display 'Login'")
        isLoginButton.tap()
        let isAuthenticationViewTitle = isApp.staticTexts["AuthenticationView_Title"]
        XCTAssertTrue(isAuthenticationViewTitle.exists, "Navigation Should Redirect From Content View To Authentication View")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
