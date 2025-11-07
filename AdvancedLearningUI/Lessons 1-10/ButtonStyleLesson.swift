//
//  ButtonStyleLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/6/25.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    var scaledAmount: CGFloat = 0.8
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1)
            .brightness(configuration.isPressed ? 0.5 : 0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.8) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

extension ButtonStyle where Self == PressableButtonStyle {
    static var pressable: PressableButtonStyle { PressableButtonStyle() }
}

struct ButtonStyleLesson: View {
    var body: some View {
        VStack(spacing: 0) {
            Button {
                
            } label: {
                Text("Click Me")
                    .withDefaultButtonFormatting()
            }
            .buttonStyle(.pressable)
            .padding(40)
            
            Button {
                
            } label: {
                Text("Click Me")
                    .withDefaultButtonFormatting()
            }
            .withPressableStyle(scaledAmount: 0.9)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
            
            Button {
                
            } label: {
                Text("Click Me")
                    .withDefaultButtonFormatting()
            }
            .buttonStyle(PressableButtonStyle(scaledAmount: 0.5))
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ButtonStyleLesson()
}
