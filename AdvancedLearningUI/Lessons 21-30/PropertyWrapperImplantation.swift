//
//  PropertyWrapperImplantation.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 2/2/26.
//

import SwiftUI
import Combine

@propertyWrapper
struct Capitalized: DynamicProperty {
    @State private var value: String
    
    var wrappedValue: String {
        get { value }
        nonmutating set { value = newValue.capitalized }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

@propertyWrapper
struct Uppercased: DynamicProperty {
    @State private var value: String
    
    var wrappedValue: String {
        get { value }
        nonmutating set { value = newValue.uppercased() }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.uppercased()
    }
}

@propertyWrapper
struct FileManagerCodableProperty<T: Codable>: DynamicProperty {
    @State private var value: T?
    let key: String
    
    var wrappedValue: T? {
        get { value }
        nonmutating set { save(newValue) }
    }
    
    var projectedValue: Binding<T?> {
        Binding(
            get: { wrappedValue },
            set: {wrappedValue = $0}
        )
    }
    
    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentsPath(key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("SUCCESS READING")
        } catch {
            _value = State(wrappedValue: nil)
            print("ERROR READING: \(error)")
        }
    }
    
    init(_ keypath: KeyPath<FileManagerValues, FileManagerKeyPath<T>>) {
        let keyPath = FileManagerValues.shared[keyPath: keypath]
        let key = keyPath.key
        
        self.key = key
        do {
            let url = FileManager.documentsPath(key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("SUCCESS READING")
        } catch {
            _value = State(wrappedValue: nil)
            print("ERROR READING: \(error)")
        }
    }
    
    private func save(_ newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key))
            value = newValue
            print("SUCCESS SAVING")
        } catch {
            print("ERROR SAVING: \(error)")
        }
    }
}

@propertyWrapper
struct FileManagerCodableStreamableProperty<T: Codable>: DynamicProperty {
    @State private var value: T?
    let key: String
    private let publisher: CurrentValueSubject<T?, Never>
    
    var wrappedValue: T? {
        get { value }
        nonmutating set { save(newValue) }
    }
    
    var projectedValue: CustomProjectedValue<T> {
        CustomProjectedValue(
            binding:
                Binding(
                    get: { wrappedValue },
                    set: {wrappedValue = $0}
                ),
            publisher: publisher)
    }
    
    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentsPath(key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("SUCCESS READING")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("ERROR READING: \(error)")
        }
    }
    
    init(_ keypath: KeyPath<FileManagerValues, FileManagerKeyPath<T>>) {
        let keyPath = FileManagerValues.shared[keyPath: keypath]
        let key = keyPath.key
        
        self.key = key
        do {
            let url = FileManager.documentsPath(key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("SUCCESS READING")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("ERROR READING: \(error)")
        }
    }
    
    private func save(_ newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key))
            value = newValue
            publisher.send(newValue)
            print("SUCCESS SAVING")
        } catch {
            print("ERROR SAVING: \(error)")
        }
    }
}

struct User: Codable {
    let name: String
    let age: Int
    let isPremium: Bool
}

struct FileManagerKeyPath<T: Codable> {
    let key: String
    let type: T.Type
}

struct FileManagerValues {
    static let shared = FileManagerValues()
    private init() { }
    
    let userProfile = FileManagerKeyPath(key: "user_profile", type: User.self)
}

struct CustomProjectedValue<T: Codable> {
    let binding: Binding<T?>
    let publisher: CurrentValueSubject<T?, Never>
    
    var stream: AsyncPublisher<CurrentValueSubject<T?, Never>> {
        publisher.values
    }
}

struct PropertyWrapperImplantation: View {
    @Capitalized private var capitalizedTitle = "Capitalized title"
    @Uppercased private var uppercasedTitle = "Uppercased title"
    @FileManagerCodableProperty(\.userProfile) private var userProfile
    @FileManagerCodableStreamableProperty("user_profile2") private var combineUserProfile: User?
    
    var body: some View {
        VStack {
            Button(capitalizedTitle) {
                capitalizedTitle = "new capitalized title"
            }
            Button(uppercasedTitle) {
                uppercasedTitle = "new uppercased title"
            }
            SomeBindingView(userProfile: $userProfile)
            
            SomeBindingView(userProfile: $combineUserProfile.binding)
            
            Button(combineUserProfile?.name ?? "No Value") {
                combineUserProfile = User(name: "Victoria Neil", age: 16, isPremium: true)
            }
        }
        .onReceive($combineUserProfile.publisher, perform: { newValue in
            print("Recived New Value of \(newValue)")
        })
        .task {
            for await newValue in $combineUserProfile.stream {
                print("Steamed New Value of \(newValue)")
            }
        }
        .onAppear {
            print(NSHomeDirectory())
        }
    }
}

struct SomeBindingView: View {
    @Binding var userProfile: User?
    var body: some View {
        Button(userProfile?.name ?? "No Value") {
            userProfile = User(name: "Davanni Wagner", age: 16, isPremium: true)
        }
    }
}

#Preview {
    PropertyWrapperImplantation()
}
