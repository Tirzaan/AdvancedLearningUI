//
//  UnitTestingLessonViewModel_Swift_Tests.swift
//  AdvancedLearningUI_Swift_Tests
//
//  Created by Tirzaan on 1/5/26.
//

import Testing
@testable import AdvancedLearningUI
import Foundation

// Naming Structure: UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: [struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Than

final class UnitTestingLessonViewModel_Swift_Tests {
    
    var viewModel: UnitTestingLessonViewModel?

    @MainActor
    init() {
        viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
    }
    
    @MainActor
    deinit {
        viewModel = nil
    }
    
    // MARK: unitTestingLessonViewModel
    
    // isPremium
    @MainActor
    @Test func unitTestingLessonViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium = true
        
        // When
        let viewModel = UnitTestingLessonViewModel(isPremium: userIsPremium)
        
        // Then
        #expect(viewModel.isPremium)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_isPremium_shouldBeFalse() {
        // Given
        let userIsPremium = false
        
        // When
        let viewModel = UnitTestingLessonViewModel(isPremium: userIsPremium)
        
        // Then
        #expect(!viewModel.isPremium)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_isPremium_shouldBeInjectedValue() {
        // Given
        let userIsPremium = Bool.random()
        
        // When
        let viewModel = UnitTestingLessonViewModel(isPremium: userIsPremium)
        
        // Then
        #expect(viewModel.isPremium == userIsPremium)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            // Given
            let userIsPremium = Bool.random()
            
            // When
            let viewModel = UnitTestingLessonViewModel(isPremium: userIsPremium)
            
            // Then
            #expect(viewModel.isPremium == userIsPremium)
        }
    }
    
    // dataArray
    @MainActor
    @Test func unitTestingLessonViewModel_dataArray_shouldBeEmpty() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given

        // When
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // Than
        #expect(viewModel.dataArray.isEmpty)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_dataArray_shouldAddItems() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        let itemToAdd = UUID().uuidString
        
        // When
        viewModel.addItem(item: itemToAdd)
        
        // Than
        #expect(viewModel.dataArray.count == 1)
        #expect(viewModel.dataArray.first == itemToAdd)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_dataArray_shouldAddItems_stress() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        for _ in 0..<10 {
            // Given
//            let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
            
            // When
            let loopCount = Int.random(in: 1...100)
            for _ in 0..<loopCount {
                viewModel.addItem(item: UUID().uuidString)
            }
            
            // Than
            #expect(viewModel.dataArray.count == loopCount)
            viewModel.dataArray.removeAll()
        }
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_dataArray_shouldNotAddBlankString() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        viewModel.addItem(item: "")
        
        // Than
        #expect(viewModel.dataArray.isEmpty)
    }
    
    // selectedItem
    @MainActor
    @Test func unitTestingLessonViewModel_selectedItem_shouldStartAsNil() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
        
        // When
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // Than
        #expect(viewModel.selectedItem == nil)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        let itemToSelect = UUID().uuidString
        viewModel.selectItem(item: itemToSelect)
        
        // Than
        #expect(viewModel.selectedItem == nil)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_selectedItem_shouldBeSelected() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        let itemToSelect = UUID().uuidString
        viewModel.dataArray.append(itemToSelect)
        viewModel.selectItem(item: itemToSelect)
        
        // Than
        #expect(viewModel.selectedItem != nil)
        #expect(viewModel.selectedItem == itemToSelect)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_selectedItem_shouldBeSelected_stress() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1...100)
        
        for _ in 0..<loopCount {
            let itemToSelect = UUID().uuidString
            viewModel.dataArray.append(itemToSelect)
            viewModel.selectItem(item: itemToSelect)
            
            // Than
            #expect(viewModel.selectedItem != nil)
            #expect(viewModel.selectedItem == itemToSelect)
        }
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItemAfterValidItem() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        // selecting valid item
        let itemToSelect = UUID().uuidString
        viewModel.dataArray.append(itemToSelect)
        viewModel.selectItem(item: itemToSelect)
        
        // selecting invalid item
        let invaliditemToSelect = UUID().uuidString
        viewModel.selectItem(item: invaliditemToSelect)
        
        // Than
        #expect(viewModel.selectedItem == nil)
    }
    
    // saveItem (func)
    @MainActor
    @Test func unitTestingLessonViewModel_saveItem_shouldThrowError_itemNotFound() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1...100)
        
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Than
        #expect(throws: DataError.itemNotFound, "Should throw item not found error!!!?") {
            try viewModel.saveItem(item: UUID().uuidString)
        }
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_saveItem_shouldThrowError_noData() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1...100)
        
        for _ in 0..<loopCount {
            viewModel.addItem(item: UUID().uuidString)
        }
        
        // Than
        #expect(throws: DataError.noData, "Should throw no data error!!!?") {
            try viewModel.saveItem(item: "")
        }
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_saveItem_shouldSaveItem() {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        let loopCount: Int = Int.random(in: 1...100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let itemToSelect = UUID().uuidString
            viewModel.addItem(item: itemToSelect)
            itemsArray.append(itemToSelect)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        #expect(!randomItem.isEmpty)
        
        // Than
        #expect(throws: Never.self, "Should throw no data error!!!?") {
            try viewModel.saveItem(item: randomItem)
        }
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_downloadWithEscaping_shouldReturnItems() async throws {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        await viewModel.downloadWithEscaping()
        
        // Than
        #expect(!viewModel.dataArray.isEmpty)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_downloadWithCombine_shouldReturnItems() async throws {
        guard let viewModel = viewModel else {
            Issue.record("viewModel is not available")
            return
        }
        
        // Given
//        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random())
        
        // When
        try await viewModel.downloadWithCombine()
        
        // Than
        #expect(!viewModel.dataArray.isEmpty)
    }
    
    @MainActor
    @Test func unitTestingLessonViewModel_downloadWithCombine_shouldReturnItemsWithCustomDataService() async throws {
        // Given
        let items: [String] = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let dataService: NewDataServiceProtocol = NewMockDataService(items: items)
        let viewModel = UnitTestingLessonViewModel(isPremium: Bool.random(), dataService: dataService)
        
        // When
        try await viewModel.downloadWithCombine()
        
        // Than
        #expect(!viewModel.dataArray.isEmpty)
        #expect(viewModel.dataArray.count == items.count)
    }

}

