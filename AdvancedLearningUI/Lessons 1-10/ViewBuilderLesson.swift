//
//  ViewBuilderLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/12/25.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            if let description {
                Text(description)
                    .font(.callout)
            }
            
            if let iconName {
                Image(systemName: iconName)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
    }
}

struct LocalViewBuilder: View {
    enum ViewType {
        case one
        case two
        case three
    }
    let type: ViewType
    
    var body: some View {
        VStack {
            header
        }
    }
    
    @ViewBuilder
    private var header: some View {
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
        
//        if type == .one {
//            viewOne
//        } else if type == .two {
//            viewTwo
//        } else if type == .three {
//            viewThree
//        }
    }
    
    private var viewOne: some View {
        Text("one")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("TWOOO")
            Image(systemName: "arrowshape.left.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "space")
    }
}

struct ViewBuilderLesson: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "New Title", description: "hello", iconName: "heart.fill")
            HeaderViewRegular(title: "Other Title", description: nil, iconName: nil)
            
            HeaderViewGeneric(title: "Generic Title") {
                Text("Hello")
            }
            
            HeaderViewGeneric(title: "Generic Two") {
                Image(systemName: "sparkles")
            }
            
            HeaderViewGeneric(title: "Generic Three") {
                HStack {
                    Text("One")
                    Image(systemName: "bolt.fill")
                    Text("Three")
                }
            }
            
            CustomHStack {
                Text("One")
                Image(systemName: "bolt.fill")
                Text("Three")
            }
            
            Spacer()
        }
    }
}

#Preview {
    LocalViewBuilder(type: .one)
}
