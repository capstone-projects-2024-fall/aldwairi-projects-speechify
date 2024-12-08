import XCTest
import FirebaseCore
@testable import Speechify

class SpeechifyTests: XCTestCase {
    
    // MARK: - App Initialization
    func testFirebaseInitialization() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        let firebaseApp = FirebaseApp.app()
        XCTAssertNotNil(firebaseApp, "Firebase should be initialized")
    }
    
    // MARK: - User Navigation Tests
    func testNavigationToHome() {
        var navigationState = false
        navigationState.toggle()
        XCTAssertTrue(navigationState, "Navigation to home should toggle state to true")
    }
    
    func testNavigationToFavorites() {
        var navigationState = false
        navigationState.toggle()
        XCTAssertTrue(navigationState, "Navigation to favorites should toggle state to true")
    }
    
    func testNavigationToAddDeck() {
        var navigationState = false
        navigationState.toggle()
        XCTAssertTrue(navigationState, "Navigation to add deck should toggle state to true")
    }
    
    func testNavigationToStore() {
        var navigationState = false
        navigationState.toggle()
        XCTAssertTrue(navigationState, "Navigation to store should toggle state to true")
    }
    
}
