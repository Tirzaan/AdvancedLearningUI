//
//  DependencyInjectionLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/5/26.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS
/*
 1. Singleton's are Global
 2. Can't customize the Init
 3. Can't swap out Dependencies
 */

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class produtionDataService: DataServiceProtocol {
//    static let instance = produtionDataService()
//    private init() { }
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    let testData: [PostsModel]
    
    init(testData: [PostsModel]?) {
        self.testData = testData ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "one"),
            PostsModel(userId: 2, id: 2, title: "Two", body: "two")
        ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], any Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

@MainActor
final class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray: [PostsModel] = []
    var cancellables: Set<AnyCancellable> = []
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)

    }
}

struct DependencyInjectionLesson: View {
    @StateObject private var viewModel: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _viewModel = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

#Preview {
//    let dataService = produtionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    let dataService = MockDataService(testData: [PostsModel(userId: 2, id: 3, title: "test", body: "test")])
    
    DependencyInjectionLesson(dataService: dataService)
}
