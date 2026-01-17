//
//  AdvancedCombineLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/9/26.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
//    @Published var basicPublisher: Int = 100
//    let currentValuePublisher = CurrentValueSubject<Int, Error>(100)
    let passThroughPublisher = PassthroughSubject<Int?, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int?, Error>()
    
    init() {
        publishData()
    }
    
    private func publishData() {
        let items = Array(0..<11)
        
        for itemIndex in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(itemIndex)) {
//                self.basicPublisher = items[itemIndex]
//                self.currentValuePublisher.send(items[itemIndex])
                self.passThroughPublisher.send(items[itemIndex])
                
                if itemIndex > 4 && itemIndex < 8 {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if itemIndex == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
    }
}

@MainActor
final class AdvancedCombineLessonViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    var cancellables = Set<AnyCancellable>()
    let multiCastPublisher = PassthroughSubject<Int?, Error>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        let sharedPublisher = dataService.passThroughPublisher
//            .dropFirst(3)
            .share()
//            .multicast {
//                PassthroughSubject<Int?, Error>()
//            }
            .multicast(subject: multiCastPublisher)
        
        sharedPublisher
        /*
            // Sequence Operations
            /*
    //            .first()
    //            .first(where: { $0 > 4 })
    //            .tryFirst(where: { int in
    //                if int == 3 {
    //                    throw URLError(.badServerResponse)
    //                }
    //                
    //                return int > 4
    //            })
    //            .last()
    //            .last(where: { $0 < 4 })
    //            .tryLast(where: { int  in
    //                if int == 13 {
    //                    throw URLError(.badServerResponse)
    //                }
    //                
    //                return int > 1
    //            })
    //            .dropFirst()
    //            .dropFirst(3)
    //            .drop(while: { $0 < 5 })
    //            .tryDrop(while: { int in
    //                if int > 10 {
    //                    throw URLError(.badServerResponse)
    //                }
    //                
    //                return int < 6
    //            })
    //            .prefix(4)
    //            .prefix(while: { $0 < 5 })
    //            .tryPrefix(while: {})
    //            .output(at: 5)
    //            .output(in: 3..<5)
            */
        
            // Mathematic Operations
            /*
    //            .max()
    //            .max(by: { int1, int2 in
    //                return int1 < int2
    //            })
    //            .tryMax(by: {})
    //            .min()
    //            .min(by: {})
    //            .tryMin(by: {})
            */
        
            // Filtering / Reducing Operations
            /*
    //            .map({ String($0) })
    //            .tryMap({ int in
    //                if int == 5 {
    //                    throw URLError(.badServerResponse)
    //                }
    //                
    //                return String(int)
    //            })
    //            .compactMap({ int in
    //                if int == 5 {
    //                    return nil
    //                }
    //                
    //                return String(int)
    //            })
    //            .tryCompactMap({})
    //            .filter({ $0 > 3 && $0 < 7 })
    //            .tryFilter({})
    //            .removeDuplicates()
    //            .removeDuplicates(by: { int1, int2 in
    //                int1 == int2
    //            })
    //            .tryRemoveDuplicates(by: {})
    //            .replaceNil(with: 5)
    //            .replaceEmpty(with: 2)
                /*
                    .tryMap({ int in
                        if int == 5 {
                            throw URLError(.badServerResponse)
                        }
                    
                        return int
                    })
                */ // V replaceError V
    //            .replaceError(with: 100)
    //            .scan(0, { existingValue, newValue in
    //                existingValue + newValue
    //            })
    //            .scan(0, { $0 + $1 })
    //            .scan(0, +)
    //            .tryScan(0, {})
    //            .reduce(0, { existingValue, newValue in
    //                existingValue + newValue
    //            })
    //            .reduce(0, +)
    //            .collect() - put below .map
    //            .collect(3)
    //            .allSatisfy({ $0 < 50})
    //            .tryAllSatisfy({})
            */
        
            // Timing Operations
            /*
    //            .debounce(for: 1, scheduler: DispatchQueue.main)
    //            .delay(for: 2, scheduler: DispatchQueue.main)
            
    //            .measureInterval(using: DispatchQueue.main)
    //            .map({ stride in
    //                return "\(stride.timeInterval)"
    //            })
            
    //            .throttle(for: 5, scheduler: DispatchQueue.main, latest: true)
    //            .retry(3)
    //            .timeout(0.75, scheduler: DispatchQueue.main)
            */
        
            // Multiple Publishers / Subscribers
            /*
//            .combineLatest(dataService.boolPublisher, dataService.intPublisher)
//            .compactMap({ $1 ? $0 : $2 })
//            .removeDuplicates()
        
//            .merge(with: dataService.intPublisher)
        
//            .zip(dataService.boolPublisher, dataService.intPublisher)
//            .map({ tuple in
//                return "\(tuple.0 ?? 0) : \(tuple.1) : \(tuple.2 ?? 0)"
//            })
        
//            .tryMap({ int in
//                if int == 5 {
//                    throw URLError(.badServerResponse)
//                }
//                
//                return int
//            })
//            .catch({ error in
//                return self.dataService.intPublisher
//            })
        */
         */
            .compactMap { $0 }
            .map(String.init)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
                
                // Used with .collect
                /*
//                self?.data = returnedValue
//                self?.data.append(contentsOf: returnedValue)
                 */
            }
            .store(in: &cancellables)
        
        sharedPublisher
            .compactMap { $0 }
            .map { (value: Int) -> Bool in value > 5 }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellables)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellables)
        }
    }
}

struct AdvancedCombineLesson: View {
    @StateObject private var viewModel = AdvancedCombineLessonViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(viewModel.data, id: \.self) { item in
                        Text(item)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .frame(maxWidth: .infinity)
                    }
                    
                    if !viewModel.error.isEmpty {
                        VStack(alignment: .center) {
                            Text("ERROR:")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundStyle(.red)
                            Text(viewModel.error)
                        }
                    }
                }
                
                VStack {
                    ForEach(viewModel.dataBools, id: \.self) { item in
                        Text(item.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineLesson()
}

