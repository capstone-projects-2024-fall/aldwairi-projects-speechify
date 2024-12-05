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

    func testContentViewSignUpNavigation() throws{
        let isApp = XCUIApplication()
        isApp.launch()
        let isViewTitle = isApp.staticTexts["ContentView_Title"]
        XCTAssertTrue(isViewTitle.exists, "Content View Should Contain A Title Text")
        XCTAssertEqual(isViewTitle.label, "Speechify", "Title Text Should Display 'Speechify'")
        let isSignUpButton = isApp.staticTexts["SignUp_Navigation"]
        XCTAssertTrue(isSignUpButton.exists, "Content View Should Contain A Sign-Up Text Button")
        XCTAssertEqual(isSignUpButton.label, "Sign-Up", "Text Button Should Display 'Sign-Up'")
        isSignUpButton.tap()
        let isRegistrationViewTitle = isApp.staticTexts["RegistrationView_Title"]
        XCTAssertTrue(isRegistrationViewTitle.exists, "Navigation Should Redirect From Content View To Registration View")
    }

    func testAuthenticationViewNavigation() throws{
        let isApp = XCUIApplication()
        isApp.launch()
        let isViewTitle = isApp.staticTexts["AuthenticationView_Title"]
        XCTAssertTrue(isViewTitle.exists, "Authentication View Should Contain A Title Text")
        XCTAssertEqual(isViewTitle.label, "Login", "Title Text Should Display 'Login'")
        let isSignUpNavigation = isApp.staticTexts["AuthenticationSignUp_Navigation"]
        XCTAssertTrue(isSignUpNavigation.exists, "Authentication View Should Contain A Sign Up Text")
        XCTAssertEqual(isSignUpNavigation.label, "Sign Up", "Text Should Display 'Sign Up'")
        isSignUpNavigation.tap()
        let isRegistrationViewTitle = isApp.staticTexts["RegistrationView_Title"]
        XCTAssertTrue(isRegistrationViewTitle.exists, "Navigation Should Redirect From Authentication View To Registration View")
        let isRegistrationAuthenticationNavigation = isApp.staticTexts["RegistrationLogin_Navigation"]
        XCTAssertTrue(isRegistrationAuthenticationNavigation.exists, "Registration View Should Contain A Login Text")
        XCTAssertEqual(isRegistrationAuthenticationNavigation.label, "Login", "Text Should Display 'Login'")
        isRegistrationAuthenticationNavigation.tap()
        let isEmailInputHeading = isApp.staticTexts["AuthenticationEmail_Heading"]
        XCTAssertTrue(isEmailInputHeading.exists, "Authentication View Should Contain A Subheading Text 'Email'")
        XCTAssertEqual(isEmailInputHeading.label, "Email", "Subheading Text Should Display 'Email'")
        let isEmailInputField = isApp.textFields["AuthenticationEmail_Input"]
        XCTAssertTrue(isEmailInputField.exists, "Authentication View Should Contain A Email TextField For User Input")
        isEmailInputField.tap()
        isEmailInputField.typeText("viktor@gmail.com")
        XCTAssertEqual(isEmailInputField.value as? String, "viktor@gmail.com", "Email TextField Value Should Be 'viktor@gmail.com'")
        let isPasswordInputHeading = isApp.staticTexts["AuthenticationPassword_Heading"]
        XCTAssertTrue(isPasswordInputHeading.exists, "Authentication View Should Contain A Subheading Text 'Password'")
        XCTAssertEqual(isPasswordInputHeading.label, "Password", "Subheading Text Should Display 'Password'")
        let isPasswordHidden = isApp.secureTextFields["AuthenticationPassword_Hidden"]
        XCTAssertTrue(isPasswordHidden.exists, "Authentication View Should Contain A Password Secure TextField For User Input")
        let isPasswordVisible = isApp.textFields["AuthenticationPassword_Visible"]
        XCTAssertFalse(isPasswordVisible.exists, "Authentication View Should Not Contain A Visible Password TextField For User Input")
        let isPasswordVisibility = isApp.buttons["AuthenticationPassword_Visibility"]
        XCTAssertTrue(isPasswordVisibility.exists, "Authentication View Should Contain A Button To Toggle TextField For User Input Visibility")
        isPasswordHidden.tap()
        isPasswordHidden.typeText("backend")
        isPasswordVisibility.tap()
        XCTAssertTrue(isPasswordVisible.exists, "Authentication View Should Have A Visible Password TextField For User Input")
        XCTAssertFalse(isPasswordHidden.exists, "Authentication View Should Not Contain A Visible Password Secure TextField For User Input")
        XCTAssertEqual(isPasswordVisible.value as? String, "backend", "Password TextField Value Should Be 'backend'")
        isPasswordVisibility.tap()
        XCTAssertTrue(isPasswordHidden.exists, "Authentication View Should Contain A Password Secure TextField For User Input")
        XCTAssertFalse(isPasswordVisible.exists, "Authentication View Should Not Contain A Visible Password TextField For User Input")
        let isLoginNavigation = isApp.staticTexts["AuthenticationLogin_Navigation"]
        XCTAssertTrue(isLoginNavigation.exists, "Authentication View Should Contain A Login Text Button")
        XCTAssertEqual(isLoginNavigation.label, "Login", "Text Button Should Display 'Login'")
        isLoginNavigation.tap()
        let isHomeUserMenu = isApp.otherElements["UserHome_Menu"]
        XCTAssertTrue(isHomeUserMenu.exists, "User Home View Should Contain An User Icon")
    }

    func testRegistrationViewNavigation() throws{
        let isApp = XCUIApplication()
        isApp.launch()
        let isViewTitle = isApp.staticTexts["RegistrationView_Title"]
        XCTAssertTrue(isViewTitle.exists, "Registration View Should Contain A Title Text")
        XCTAssertEqual(isViewTitle.label, "Sign-Up", "Title Text Should Display 'Sign-Up'")
        let isLoginNavigation = isApp.staticTexts["RegistrationLogin_Navigation"]
        XCTAssertTrue(isLoginNavigation.exists, "Registration View Should Contain A Login Text")
        XCTAssertEqual(isLoginNavigation.label, "Login", "Text Should Display 'Login'")
        isLoginNavigation.tap()
        let isAuthenticationViewTitle = isApp.staticTexts["AuthenticationView_Title"]
        XCTAssertTrue(isAuthenticationViewTitle.exists, "Navigation Should Redirect From Registration View To Authentication View")
        let isAuthenticationRegistrationNavigation = isApp.staticTexts["AuthenticationSignUp_Navigation"]
        XCTAssertTrue(isAuthenticationRegistrationNavigation.exists, "Authentication View Should Contain A Sign Up Text")
        XCTAssertEqual(isAuthenticationRegistrationNavigation.label, "Sign Up", "Text Should Display 'Sign Up'")
        isAuthenticationRegistrationNavigation.tap()
        let isUserNameInputHeading = isApp.staticTexts["RegistrationUserName_Heading"]
        XCTAssertTrue(isUserNameInputHeading.exists, "Registration View Should Contain A Subheading Text 'Username'")
        XCTAssertEqual(isUserNameInputHeading.label, "Username", "Subheading Text Should Display 'Username'")
        let isUserNameInputField = isApp.textFields["RegistrationUserName_Input"]
        XCTAssertTrue(isUserNameInputField.exists, "Registration View Should Contain A Email TextField For User Input")
        isUserNameInputField.tap()
        isUserNameInputField.typeText("gheedorah")
        XCTAssertEqual(isUserNameInputField.value as? String, "gheedorah", "Username TextField Value Should Be 'gheedorah'")
        let isEmailInputHeading = isApp.staticTexts["RegistrationEmail_Heading"]
        XCTAssertTrue(isEmailInputHeading.exists, "Registration View Should Contain A Subheading Text 'Email'")
        XCTAssertEqual(isEmailInputHeading.label, "Email", "Subheading Text Should Display 'Email'")
        let isEmailInputField = isApp.textFields["RegistrationEmail_Input"]
        XCTAssertTrue(isEmailInputField.exists, "Registration View Should Contain A Email TextField For User Input")
        isEmailInputField.tap()
        isEmailInputField.typeText("gheedorah@gmail.com")
        XCTAssertEqual(isEmailInputField.value as? String, "gheedorah@gmail.com", "Email TextField Value Should Be 'gheedorah@gmail.com'")
        let isPasswordInputHeading = isApp.staticTexts["RegistrationPassword_Heading"]
        XCTAssertTrue(isPasswordInputHeading.exists, "Registration View Should Contain A Subheading Text 'Password'")
        XCTAssertEqual(isPasswordInputHeading.label, "Password", "Subheading Text Should Display 'Password'")
        let isPasswordHidden = isApp.secureTextFields["RegistrationPassword_Hidden"]
        XCTAssertTrue(isPasswordHidden.exists, "Registration View Should Contain A Password Secure TextField For User Input")
        let isPasswordVisible = isApp.textFields["RegistrationPassword_Visible"]
        XCTAssertFalse(isPasswordVisible.exists, "Registration View Should Not Contain A Visible Password TextField For User Input")
        let isPasswordVisibility = isApp.buttons["RegistrationPassword_Visibility"]
        XCTAssertTrue(isPasswordVisibility.exists, "Registration View Should Contain A Button To Toggle TextField For User Input Visibility")
        isPasswordHidden.tap()
        isPasswordHidden.typeText("monsterzero")
        isPasswordVisibility.tap()
        XCTAssertTrue(isPasswordVisible.exists, "Registration View Should Have A Visible Password TextField For User Input")
        XCTAssertFalse(isPasswordHidden.exists, "Registration View Should Not Contain A Visible Password Secure TextField For User Input")
        XCTAssertEqual(isPasswordVisible.value as? String, "monsterzero", "Password TextField Value Should Be 'monsterzero'")
        isPasswordVisibility.tap()
        XCTAssertTrue(isPasswordHidden.exists, "Registration View Should Contain A Password Secure TextField For User Input")
        XCTAssertFalse(isPasswordVisible.exists, "Registration View Should Not Contain A Visible Password TextField For User Input")
        let isConfirmPasswordInputHeading = isApp.staticTexts["RegistrationConfirmPassword_Heading"]
        XCTAssertTrue(isConfirmPasswordInputHeading.exists, "Registration View Should Contain A Subheading Text 'Confirm Password'")
        XCTAssertEqual(isConfirmPasswordInputHeading.label, "Confirm Password", "Subheading Text Should Display 'Confirm Password'")
        let isConfirmPasswordHidden = isApp.secureTextFields["RegistrationConfirmPassword_Hidden"]
        XCTAssertTrue(isConfirmPasswordHidden.exists, "Registration View Should Contain A Confirm Password Secure TextField For User Input")
        let isConfirmPasswordVisible = isApp.textFields["RegistrationConfirmPassword_Visible"]
        XCTAssertFalse(isConfirmPasswordVisible.exists, "Registration View Should Not Contain A Visible Confirm Password TextField For User Input")
        let isConfirmPasswordVisibility = isApp.buttons["RegistrationConfirmPassword_Visibility"]
        XCTAssertTrue(isConfirmPasswordVisibility.exists, "Registration View Should Contain A Button To Toggle TextField For User Input Visibility")
        isConfirmPasswordHidden.tap()
        isConfirmPasswordHidden.typeText("monsterzero")
        isConfirmPasswordVisibility.tap()
        XCTAssertTrue(isConfirmPasswordVisible.exists, "Registration View Should Have A Visible Confirm Password TextField For User Input")
        XCTAssertFalse(isConfirmPasswordHidden.exists, "Registration View Should Not Contain A Visible Confirm Password Secure TextField For User Input")
        XCTAssertEqual(isConfirmPasswordVisible.value as? String, "monsterzero", "Confirm Password TextField Value Should Be 'monsterzero'")
        isConfirmPasswordVisibility.tap()
        XCTAssertTrue(isConfirmPasswordHidden.exists, "Registration View Should Contain A Confirm Password Secure TextField For User Input")
        XCTAssertFalse(isConfirmPasswordVisible.exists, "Registration View Should Not Contain A Visible Confirm Password TextField For User Input")
        let isSignUpNavigation = isApp.staticTexts["RegistrationSignUp_Navigation"]
        XCTAssertTrue(isSignUpNavigation.exists, "Registration View Should Contain A Sign Up Text Button For User Input")
        XCTAssertEqual(isSignUpNavigation.label, "Sign Up", "Text Button Should Display 'Sign Up'")
        isSignUpNavigation.tap()
        let isInitialPersonalizationTitle = isApp.staticTexts["InitialPersonalizationView_Title"]
        XCTAssertTrue(isInitialPersonalizationTitle.exists, "Initial Personalization View Should Contain A Title Text")
        XCTAssertEqual(isInitialPersonalizationTitle.label, "Personalization", "Title Text Should Display 'Personalization'")
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
