//
//  UnitTestingLessonViewModel.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/5/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class UnitTestingLessonViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    let dataService: NewDataServiceProtocol
    var cancellables: Set<AnyCancellable> = []
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewMockDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let itemToSelect = dataArray.first(where: { $0 == item }) {
            selectedItem = itemToSelect
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let itemToSave = dataArray.first(where: { $0 == item }) {
            print("Save Item(\(itemToSave)) Here!!!")
        } else {
            throw DataError.itemNotFound
        }
    }
    
    func downloadWithEscaping() async {
        await withCheckedContinuation { continuation in
            dataService.downloadItemsWithEscaping { [weak self] returnedItems in
                self?.dataArray = returnedItems
                continuation.resume()
            }
        }
    }
    
    func downloadWithCombine() async throws {
        for try await items in dataService.downloadItemsWithCombine().values {
            self.dataArray = items
        }
    }


}

enum DataError: LocalizedError {
    case noData
    case itemNotFound
}
