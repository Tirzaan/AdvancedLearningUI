//
//  CustomBindingLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/16/26.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue {
                value.wrappedValue = nil
            }
        }
    }
}

struct CustomBindingLesson: View {
    @State var title: String = "Start"
    
    @State private var errorTitle: String? = nil
//    @State private var showError: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text("Main: ")
                    .fontWeight(.black)
                Text(title)
            }
            
    
            
            HStack(spacing: 0) {
                Text("Child View: ")
                    .fontWeight(.black)
                ChildView(title: $title)
            }
            
            HStack(spacing: 0) {
                Text("Secondary: ")
                    .fontWeight(.black)
                SecondaryChildView(title: title) { newTitle in
                    title = newTitle
                }
            }
            
            HStack(spacing: 0) {
                Text("Tertiary: ")
                    .fontWeight(.black)
                TertiaryChildView(title: $title)
            }
            
            HStack(spacing: 0) {
                Text("Tertiary pt 2: ")
                    .fontWeight(.black)
                TertiaryChildView(title: Binding(get: {
                    title
                }, set: { newValue in
                    title = newValue + "*"
                }))
            }
            
            Button("Click Me") {
                errorTitle = "New Error!!!"
//                showError.toggle()
            }
        }
        .font(.title2)
        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
            
        }
//        .alert(errorTitle ?? "Error", isPresented: Binding(get: {
//            errorTitle != nil
//        }, set: { newValue in
//            if !newValue {
//                errorTitle = nil
//            }
//        })) {
//            
//        }
//        .alert(errorTitle ?? "Error", isPresented: $showError) {
//            
//        }
    }
}

struct ChildView: View {
    @Binding var title: String
    
    var body: some View {
        Text(title)
            .onTapGesture {
                title = title + "!"
            }
    }
}

struct SecondaryChildView: View {
    var title: String
    let setTitle: (String) -> ()
    
    var body: some View {
        Text(title)
            .onTapGesture {
                setTitle(title + "?")
            }
    }
}

struct TertiaryChildView: View {
    let title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onTapGesture {
                title.wrappedValue = title.wrappedValue + "&"
            }
    }
}

#Preview {
    CustomBindingLesson()
}
