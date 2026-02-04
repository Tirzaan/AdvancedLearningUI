//
//  SubscriptsLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 2/3/26.
//

import SwiftUI

extension Array {
    /*
//    subscript(atIndex: Int) -> Element? {
//        for (index, element) in self.enumerated() {
//            if index == atIndex + 1 {
//                return element
//            }
//        }
//        
//        return nil
//    }
     */
}

extension Array where Element == String {
    subscript(value: String) -> Element? {
        return self.first(where: { $0 == value })
    }
}

struct Address {
    let street: String
    let city: City
}

struct City {
    let name: String
    let state: String
}

struct Customer {
    let name: String
    let address: Address
    
    subscript(value: String) -> String {
        switch value {
        case "name":
            return name
        case "address":
            return "\(address.street), \(address.city.name), \(address.city.state)"
        case "city":
            return "\(address.city.name)"
        default:
            fatalError()
        }
    }
    
    subscript(index: Int) -> String {
        switch index {
        case 0:
            return name
        case 1:
            return "\(address.street), \(address.city.name), \(address.city.state)"
        default:
            fatalError()
        }
    }
}

struct SubscriptsLesson: View {
    @State private var myArray: [String] = ["ONE", "TWO", "THREE"]
    @State private var selectedItem: String? = nil
    
    var body: some View {
        VStack {
            ForEach(myArray, id: \.self) { string in
                Text(string)
            }
            
            Text("Selected: \(selectedItem ?? "None")")
        }
        .onAppear {
//            let value = "ONE"
//            selectedItem = myArray.first(where: { $0 == value })
//            selectedItem = myArray["TWO"]
            
            let customer = Customer(name: "Victoria Colvin", address: Address(street: "Main St", city: City(name: "Columbus", state: "Ohio")))
            selectedItem = customer["city"]
//            selectedItem = customer[1]
            
//            selectedItem = myArray[0]
        }
    }
}

#Preview {
    SubscriptsLesson()
}
