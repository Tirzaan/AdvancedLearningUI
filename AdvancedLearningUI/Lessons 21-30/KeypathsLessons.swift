//
//  KeypathsLessons.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/27/26.
//

import SwiftUI

struct MyDataModel: Identifiable {
    let id = UUID().uuidString
    let title: String //movieTitle
    let count: Int
    let date: Date
}

//struct movieTitle {
//    let primary: String
//    let secondary: String
//}

extension Array {
    mutating func sortByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, assending: Bool = true) {
        self.sort { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return assending ? value1 < value2 : value1 > value2
        }
    }
    
    func sortedByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, assending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return assending ? value1 < value2 : value1 > value2
        }
    }
}

struct KeypathsLessons: View {
    
//    @State private var screenTitle: String = ""
    @State private var dataArray: [MyDataModel] = []

    var body: some View {
        ScrollView {
            ForEach(dataArray) { item in
                VStack {
                    Text("Title: \(item.title)")
                    Text("Id: \(item.id)")
                    Text("Count: \(item.count)")
                    Text("Date: \(item.date, style: .date)")
                }
                .font(.headline)
                Divider()
            }
        }
            .onAppear {
                var array = [
                    MyDataModel(title: "THREE", count: 3, date: .distantFuture),
                    MyDataModel(title: "ONE", count: 1, date: .now),
                    MyDataModel(title: "TWO", count: 2, date: .distantPast),
                ]
                
//                let newArray = array.sorted { item1, item2 in
//                    item1[keyPath: \.count] < item2[keyPath: \.count]
//                }
                
//                let newArray = array.sortedByKeyPath(\.count, assending: false)
                array.sortByKeyPath(\.count)
                
                dataArray = array
            }
    }
}

#Preview {
    KeypathsLessons()
}
