//
//  MatchedGeometryEffectLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/6/25.
//

import SwiftUI

struct MatchedGeometryEffectLesson: View {
    @State private var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "Rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }
            
            Spacer()
            
            if isClicked {
                Capsule()
                    .matchedGeometryEffect(id: "Rectangle", in: namespace)
                    .frame(width: 300, height: 200)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.opacity(0.5))
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectExample2: View {
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace2
    
    var body: some View {
        HStack {
            ForEach(categories, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red)
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                            .frame(width: 70, height: 3)
                            .offset(y: 10)
                    }
                    
                    Text(category)
                        .foregroundStyle(selected == category ? .red : .primary)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    MatchedGeometryEffectExample2()
}
