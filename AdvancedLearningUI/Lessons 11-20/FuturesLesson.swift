//
//  FuturesLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/12/26.
//

import SwiftUI
import Combine

// download with combine
// download with @escaping closures
// convert @escaping closures to combine

@MainActor
final class FuturesLessonViewModel: ObservableObject {
    @Published var title: String = "Starting Title"
    let url = URL(string: "https://www.example.com")!
    var cancellables = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
//        getCombinePublisher()
        getFuturePublisher()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedValue in
                self?.title = returnedValue
            }
            .store(in: &cancellables)
        
//        getEscapingClosure { [weak self] returnedValue, error in
//            self?.title = returnedValue
//        }
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                "New Title"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("Newer Title", nil)
        }
        .resume()
    }
    
    func getFuturePublisher() -> Future<String, Error> {
        Future { [weak self] promise in
                self?.getEscapingClosure { returnedValue, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(returnedValue))
                }
            }
        }
    }
    
    func doSomething(completionHandler: @escaping (_ value: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completionHandler("Newest String")
        }
    }
    
    func doSomthingInTheFuture() -> Future<String, Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
}

struct FuturesLesson: View {
    @StateObject private var viewModel = FuturesLessonViewModel()
    
    var body: some View {
        Text(viewModel.title)
    }
}

#Preview {
    FuturesLesson()
}
