//
//  GenericsLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/11/25.
//

import SwiftUI
import Combine

struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct BoolModel {
    let info: Bool?
    
    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}

struct GenericModel<type> {
    let info: type?
    
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

@MainActor
final class GenericsLessonViewModel: ObservableObject {
    @Published var stringModel = StringModel(info: "Hello World!")
    @Published var boolModel = BoolModel(info: true)
    
    @Published var genericStringModel = GenericModel(info: "Hello Everyone!")
    @Published var genericBoolModel = GenericModel(info: false)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<type: View>: View {
    let title: String
    let content: type
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsLesson: View {
    @StateObject private var viewModel = GenericsLessonViewModel()
    
    var body: some View {
        VStack {
            GenericView(title: "new View", content: Text("Hi!"))
            Divider()
            
            Text(viewModel.stringModel.info ?? "no data")
            Text(viewModel.boolModel.info?.description ?? "no data")
            Divider()
            
            Text(viewModel.genericStringModel.info ?? "no data")
            Text(viewModel.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture {
            viewModel.removeData()
        }
    }
}

#Preview {
    GenericsLesson()
}
