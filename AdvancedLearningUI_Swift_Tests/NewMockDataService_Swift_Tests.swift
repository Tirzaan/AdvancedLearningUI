//
//  NewMockDataService_Swift_Tests.swift
//  AdvancedLearningUI_Swift_Tests
//
//  Created by Tirzaan on 1/6/26.
//

import Foundation
import Testing
@testable import AdvancedLearningUI
import Combine

struct NewMockDataService_Swift_Tests {

    @Test func NewMockDataService_init_doesSetValuesCorrectly() {
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService = NewMockDataService(items: items)
        let dataService2 = NewMockDataService(items: items2)
        let dataService3 = NewMockDataService(items: items3)
        
        // Then
        #expect(!dataService.items.isEmpty)
        #expect(dataService2.items.isEmpty)
        #expect(dataService3.items.count == items3?.count)
    }
    
    @MainActor
    @Test func NewMockDataService_downloadWithEscaping_doesReturnValues() async {
        // Given
        let dataService = NewMockDataService(items: nil)
        
        // When
        let items = await withCheckedContinuation { continuation in
            dataService.downloadItemsWithEscaping { returnedItems in
                    continuation.resume(returning: returnedItems)
                }
            }
        
        // Then
        #expect(items.count == dataService.items.count)
    }
    
    @MainActor
    @Test func NewMockDataService_downloadWithCombine_doesReturnValues() async throws {
        // Given
        let dataService = NewMockDataService(items: nil)
        let publisher = dataService.downloadItemsWithCombine()
        
        // When
        let result: [String] = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[String], Error>) in
            var cancellable: AnyCancellable?
            cancellable = publisher.sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                },
                receiveValue: { value in
                    continuation.resume(returning: value)
                    cancellable?.cancel()
                }
            )
        }
        
        // Then
        #expect(result.count == dataService.items.count)
    }
    
    @MainActor
    @Test func NewMockDataService_downloadWithCombine_doesfail() async throws {
        // Given
        let dataService = NewMockDataService(items: [])
        let publisher = dataService.downloadItemsWithCombine()
        
        var topError: any Error = NSError(domain: "Test", code: 0)
        var topValue: [String] = []
        
        // When
        let result: [String] = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[String], Error>) in
            var cancellable: AnyCancellable?
            cancellable = publisher.sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        topError = error
                        continuation.resume(returning: topValue)
                    }
                    cancellable?.cancel()
                },
                receiveValue: { value in
                    topValue = value
                    continuation.resume(throwing: topError)
                    cancellable?.cancel()
                }
            )
        }
        
        let urlError = topError as? URLError
        
        // Then
        #expect(urlError == URLError(.badServerResponse))
        #expect(result.count == dataService.items.count)
    }

}
