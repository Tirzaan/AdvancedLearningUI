//
//  ViewModifierLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/6/25.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
    }
}

extension View {
    func withDefaultButtonFormatting(_ backgroundColor: Color = .blue) -> some View {
//        self
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierLesson: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello, World!")
                .font(.headline)
                .withDefaultButtonFormatting(.orange)
            
            Text("Hello, Everyone!")
                .font(.subheadline)
                .withDefaultButtonFormatting()

            Text("Hello!")
                .font(.title)
                .modifier(DefaultButtonViewModifier(backgroundColor: .green))
        }
        .padding()
    }
}

#Preview {
    ViewModifierLesson()
}
