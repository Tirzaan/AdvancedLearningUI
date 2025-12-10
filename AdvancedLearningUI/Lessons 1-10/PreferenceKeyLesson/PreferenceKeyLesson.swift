//
//  PreferenceKeyLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/25/25.
//



import SwiftUI

struct PreferenceKeyLesson: View {
    @State private var text: String = "Hello, world!"
    
    var body: some View {
        NavigationStack {
            VStack {
                SecondaryScreen(text: text)
                    .navigationTitle("Nav Title")
//                    .customTitle("New Value!!")
            }
            .onPreferenceChange(CustomTitlePreferenceKey.self) { value in
                self.text = value
            }
        }
    }
}

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct SecondaryScreen: View {
    let text: String
    @State private var newValue: String = ""
    
    var body: some View {
        Text(text)
            .onAppear { getDataFromDatabase() }
            .customTitle(newValue)
    }
    
    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "New Value From Database"
        }
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = "something"
    
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

#Preview {
    PreferenceKeyLesson()
}
