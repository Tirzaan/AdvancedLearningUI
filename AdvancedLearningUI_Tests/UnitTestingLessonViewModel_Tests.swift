//
//  UnitTestingLessonViewModel_Tests.swift
//  AdvancedLearningUI_Tests
//
//  Created by Tirzaan on 1/5/26.
//

import XCTest
@testable import AdvancedLearningUI

// Naming Structure: "test"_UnitOfWork_StateUnderTest_ExpectedBehavior
// Testing Structure: Given, When, Than

final class UnitTestingLessonViewModel_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func test_UnitTestingLessonViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        
        // When
        let viewModel = UnitTestingLessonViewModel(isPremium: userIsPremium)
        
        // Than
        XCTAssertTrue(viewModel.isPremium)
    }
}
