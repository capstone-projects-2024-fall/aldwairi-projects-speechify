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

    func testInitialUserPersonalizationNavigation() throws{
        let isApp = XCUIApplication()
        isApp.launch()
        let isViewTitle = isApp.staticTexts["InitialPersonalizationView_Title"]
        XCTAssertTrue(isViewTitle.exists, "Initial Personalization View Should Contain A Title Text")
        XCTAssertEqual(isViewTitle.label, "Personalization", "Title Text Should Display 'Personalization'")
        let isGenderDropDown = isApp.otherElements["InitialPersonalizationGender_DropDown"]
        let isBirthDayDropDown = isApp.otherElements["InitialPersonalizationBirthDay_DropDown"]
        let isBirthMonthDropDown = isApp.otherElements["InitialPersonalizationBirthMonth_DropDown"]
        let isBirthYearDropDown = isApp.otherElements["InitialPersonalizationBirthYear_DropDown"]
        let isNativeLanguageDropDown = isApp.otherElements["InitialPersonalizationNativeLanguage_DropDown"]
        let isLearnLanguageDropDown = isApp.otherElements["InitialPersonalizationLearnLanguage_DropDown"]
        let isLanguageThemeDropDown = isApp.otherElements["InitialPersonalizationLanguageTheme_DropDown"]
        XCTAssertFalse(isGenderDropDown.exists, "Initial Personalization View Should Not Contain A Gender Drop Down Overlay")
        XCTAssertFalse(isBirthDayDropDown.exists, "Initial Personalization View Should Not Contain A Birth Day Drop Down Overlay")
        XCTAssertFalse(isBirthMonthDropDown.exists, "Initial Personalization View Should Not Contain A Birth Month Drop Down Overlay")
        XCTAssertFalse(isBirthYearDropDown.exists, "Initial Personalization View Should Not Contain A Birth Year Drop Down Overlay")
        XCTAssertFalse(isNativeLanguageDropDown.exists, "Initial Personalization View Should Not Contain A Native Language Drop Down Overlay")
        XCTAssertFalse(isLearnLanguageDropDown.exists, "Initial Personalization View Should Not Contain A Learn Language Drop Down Overlay")
        XCTAssertFalse(isLanguageThemeDropDown.exists, "Initial Personalization View Should Not Contain A Language Theme Drop Down Overlay")
        let isGenderHeading = isApp.staticTexts["InitialPersonalizationGender_Heading"]
        XCTAssertTrue(isGenderHeading.exists, "Initial Personalization View Should Contain A Subheading Text 'Select Your Gender'")
        XCTAssertEqual(isGenderHeading.label, "Select Your Gender", "Subheading Text Should Display 'Select Your Gender'")
        let isGenderMenu = isApp.otherElements["InitialPersonalizationGender_Menu"]
        XCTAssertTrue(isGenderMenu.exists, "Initial Personalization View Should Contain A Gender Text Drop Down Button")
        XCTAssertEqual(isGenderMenu.label, "Gender", "Text Drop Down Button Should Display 'Gender'")
        isGenderMenu.tap()
        XCTAssertTrue(isGenderDropDown.exists, "Initial Personalization View Should Contain A Gender Drop Down Overlay")
        //Checkif other textfield exist
        let isMaleOption = isApp.otherElements["InitialPersonalizationGender_Male"]
        XCTAssertTrue(isMaleOption.exists, "Initial Personalization View Should Contain A Male Option In The Gender Drop Down Overlay")
        isMaleOption.tap()
        let isDateOfBirthHeading = isApp.staticTexts["InitialPersonalizationDateOfBirth_Heading"]
        XCTAssertTrue(isDateOfBirthHeading.exists, "Initial Personalization View Should Contain A Subheading Text 'Enter Your Date Of Birth'")
        XCTAssertEqual(isDateOfBirthHeading.label, "Enter Your Date Of Birth", "Subheading Text Should Display 'Enter Your Date Of Birth'")
        let isBirthDayMenu = isApp.otherElements["InitialPersonalizationBirthDay_Menu"]
        XCTAssertTrue(isBirthDayMenu.exists, "Initial Personalization View Should Contain A Day Text Drop Down Button")
        isBirthDayMenu.tap()
        XCTAssertTrue(isBirthDayDropDown.exists, "Initial Personalization View Should Contain A Birth Day Drop Down Overlay")
        let isDayOption = isApp.otherElements["InitialPersonalizationBirthDay_17"]
        XCTAssertTrue(isDayOption.exists, "Initial Personalization View Should Contain The 17th Day As An Option In The Birth Day Drop Down Overlay")
        isDayOption.tap()
        let isBirthMonthMenu = isApp.otherElements["InitialPersonalizationBirthMonth_Menu"]
        XCTAssertTrue(isBirthMonthMenu.exists, "Initial Personalization View Should Contain A Month Text Drop Down Button")
        isBirthMonthMenu.tap()
        XCTAssertTrue(isBirthMonthDropDown.exists, "Initial Personalization View Should Contain A Birth Month Drop Down Overlay")
        let isMonthOption = isApp.otherElements["InitialPersonalizationBirthMonth_Jun"]
        XCTAssertTrue(isMonthOption.exists, "Initial Personalization View Should Contain The Month Jun As An Option In The Birth Month Drop Down Overlay")
        isMonthOption.tap()
        let isBirthYearMenu = isApp.otherElements["InitialPersonalizationBirthYear_Menu"]
        XCTAssertTrue(isBirthYearMenu.exists, "Initial Personalization View Should Contain A Year Text Drop Down Button")
        isBirthYearMenu.tap()
        XCTAssertTrue(isBirthYearDropDown.exists, "Initial Personalization View Should Contain A Birth Year Drop Down Overlay")
        let isYearOption = isApp.otherElements["InitialPersonalizationBirthYear_2003"]
        XCTAssertTrue(isYearOption.exists, "Initial Personalization View Should Contain The Year 2003 As An Option In The Birth Year Drop Down Overlay")
        isYearOption.tap()
        let isNativeLanguageHeading = isApp.staticTexts["InitialPersonalizationNativeLanguage_Heading"]
        XCTAssertTrue(isNativeLanguageHeading.exists, "Initial Personalization View Should Contain A Subheading Text 'Select Your Native Language(s)'")
        XCTAssertEqual(isNativeLanguageHeading.label, "Select Your Native Language(s)", "Subheading Text Should Display 'Select Your Native Language(s)'")
        let isNativeLanguageMenu = isApp.otherElements["InitialPersonalizationNativeLanguage_Menu"]
        XCTAssertTrue(isNativeLanguageMenu.exists, "Initial Personalization View Should Contain A Native Language Text Drop Down Button")
        isNativeLanguageMenu.tap()
        XCTAssertTrue(isNativeLanguageDropDown.exists, "Initial Personalization View Should Contain A Native Language Drop Down Overlay")
        let isNativeLanguageOption = isApp.otherElements["InitialPersonalizationNativeLanguage_Arabic"]
        XCTAssertTrue(isNativeLanguageOption.exists, "Initial Personalization View Should Contain Arabic As An Option In The Native Language Drop Down Overlay")
        isNativeLanguageOption.tap()
        isNativeLanguageMenu.tap()
        let isLearnLanguageHeading = isApp.staticTexts["InitialPersonalizationLearnLanguage_Heading"]
        XCTAssertTrue(isLearnLanguageHeading.exists, "Initial Personalization View Should Contain A Subheading Text 'Select Language(s) To Learn'")
        XCTAssertEqual(isLearnLanguageHeading.label, "Select Language(s) To Learn", "Subheading Text Should Display 'Select Language(s) To Learn'")
        let isLearnLanguageMenu = isApp.otherElements["InitialPersonalizationLearnLanguage_Menu"]
        XCTAssertTrue(isLearnLanguageMenu.exists, "Initial Personalization View Should Contain A Learn Language Text Drop Down Button")
        isLearnLanguageMenu.tap()
        XCTAssertTrue(isLearnLanguageDropDown.exists, "Initial Personalization View Should Contain A Learn Language Drop Down Overlay")
        let isLearnLanguageOption = isApp.otherElements["InitialPersonalizationLearnLanguage_English (US)"]
        XCTAssertTrue(isLearnLanguageOption.exists, "Initial Personalization View Should Contain English (US) As An Option In The Learn Language Drop Down Overlay")
        isLearnLanguageOption.tap()
        isLearnLanguageMenu.tap()
        let isLanguageThemeHeading = isApp.staticTexts["InitialPersonalizationLanguageTheme_Heading"]
        XCTAssertTrue(isLanguageThemeHeading.exists, "Initial Personalization View Should Contain A Subheading Text 'Select Language Theme(s)'")
        XCTAssertEqual(isLanguageThemeHeading.label, "Select Language Theme(s)", "Subheading Text Should Display 'Select Language Theme(s)'")
        let isLanguageThemeMenu = isApp.otherElements["InitialPersonalizationLanguageTheme_Menu"]
        XCTAssertTrue(isLanguageThemeMenu.exists, "Initial Personalization View Should Contain A Language Theme Text Drop Down Button")
        isLanguageThemeMenu.tap()
        XCTAssertTrue(isLanguageThemeDropDown.exists, "Initial Personalization View Should Contain A Language Theme Drop Down Overlay")
        let isLanguageThemeOption = isApp.otherElements["InitialPersonalizationLanguageTheme_Culture"]
        XCTAssertTrue(isLanguageThemeOption.exists, "Initial Personalization View Should Contain Culture As An Option In The Language Theme Drop Down Overlay")
        isLanguageThemeOption.tap()
        isLanguageThemeMenu.tap()
        let isInitialPersonalizationNavigation = isApp.staticTexts["InitialPersonalizationCompletion_Navigation"]
        XCTAssertTrue(isInitialPersonalizationNavigation.exists, "Initial Personalization View Should Contain A Finish Text Button")
        XCTAssertEqual(isInitialPersonalizationNavigation.label, "Finish", "Text Button Should Display 'Finish'")
        let isHomeUserMenu = isApp.otherElements["UserHome_Menu"]
        XCTAssertTrue(isHomeUserMenu.exists, "User Home View Should Contain An User Icon")
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
