//
//  UITestingLessonView_UITests.swift
//  AdvancedLearningUI_UITests
//
//  Created by Tirzaan on 1/7/26.
//

import XCTest

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct]_[UI component]_[expected result]
// Testing Structure: Given, When, Than


final class UITestingLessonView_UITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
//        app.launchArguments = ["-UITest_startSignedIn"]
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }

    // Sign Up Button
    func test_UITestingLessonView_SignUpButton_shouldNotSignUp() {
        // Given
        signUp(shouldTypeOnKeyboard: false)
        
        // When
        let navBar = app.navigationBars["Welcome"]
        
        // Than
        XCTAssertFalse(navBar.exists)
    }
    
    func test_UITestingLessonView_SignUpButton_shouldSignUp() {
        // Given
        signUp(shouldTypeOnKeyboard: true)
        
        // When
        let navBar = app.navigationBars["Welcome"]
        
        // Than
        XCTAssertTrue(navBar.exists)
    }
    
    // Show Welcome Alert Button
    func test_signedInHomeView_showWelcomeAlertButton_shouldDisplayAlert() {
        // Given
        signUp(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: false)
        
        // Than
        let alert = app.alerts["Welcome to the app!"]
        XCTAssertTrue(alert.exists)
    }
    
    func test_signedInHomeView_showWelcomeAlertButton_shouldDisplayAndDismissAlert() {
        // Given
        signUp(shouldTypeOnKeyboard: true)
        
        // When
        tapAlertButton(shouldDismissAlert: true)
        
        // Than
        let alert = app.alerts["Welcome to the app!"]
        XCTAssertFalse(alert.exists)
    }
    
    // Navigate to Profile Button
    func test_signedInHomeView_navigateToProfileButton_shouldNavigateToProfileView() {
        // Given
        signUp(shouldTypeOnKeyboard: true)
        
        // When
        tapProfileNavigationButton(shouldDismissScreen: false)
        
        // Than
        let profileScreen = app.staticTexts["Profile Screen"].firstMatch
        XCTAssertTrue(profileScreen.exists)
    }
    
    func test_signedInHomeView_navigateToProfileButton_shouldNavigateToAndFromProfileView() {
        // Given
        signUp(shouldTypeOnKeyboard: true)
        
        // When
        tapProfileNavigationButton(shouldDismissScreen: true)
        
        // Than
        let navBar = app.navigationBars["Welcome"]
        XCTAssertTrue(navBar.exists)
    }
    
    
    // USE WITH THE launchArguments UNCOMMENTED (in the init)
//    func test_signedInHomeView_navigateToProfileButton_shouldNavigateToAndFromProfileViewWithSignedIn() {
//        // Given
//        
//        // When
//        tapProfileNavigationButton(shouldDismissScreen: true)
//        
//        // Than
//        let navBar = app.navigationBars["Welcome"]
//        XCTAssertTrue(navBar.exists)
//    }
}

// MARK: FUNCTIONS
extension UITestingLessonView_UITests {
    func signUp(shouldTypeOnKeyboard: Bool) {
        let textField = app.textFields["Sign Up TextField"]
        textField.tap()
        
        if shouldTypeOnKeyboard {
            app.keys["B"].firstMatch.tap()
            app.keys["o"].firstMatch.tap()
            app.keys["b"].firstMatch.tap()
        }
        
        app.buttons["Return"].firstMatch.tap()
        
        app.buttons["Sign Up Button"].firstMatch.tap()
    }
    
    func tapAlertButton(shouldDismissAlert: Bool) {
        let showAlertButton = app.buttons["Show Welcome Alert Button"]
        showAlertButton.tap()
        
        if shouldDismissAlert {
            let dismissButton = app.buttons["OK"]
            dismissButton.tap()
        }
    }
    
    func tapProfileNavigationButton(shouldDismissScreen: Bool) {
        app.buttons["Navigate to Profile Button"].firstMatch.tap()
        
        if shouldDismissScreen {
            app.buttons["BackButton"].firstMatch.tap()
        }
    }
}
