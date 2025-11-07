//
//  AnyTransitionLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/6/25.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .rotationEffect(Angle(degrees: rotation))
                .offset(
                    x: rotation != 0 ? proxy.size.width : 0,
                    y: rotation != 0 ? proxy.size.height : 0
                )
        }
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        modifier(
                active: RotateViewModifier(rotation: 180),
                identity: RotateViewModifier(rotation: 0)
            )
    }
    
    static func rotating(rotation: Double) -> AnyTransition {
        modifier(
                active: RotateViewModifier(rotation: rotation),
                identity: RotateViewModifier(rotation: 0)
            )
    }
    
    static var rotateOn: AnyTransition {
        asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading)
        )
    }
}

struct AnyTransitionLesson: View {
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Text("Show Rectangle!")
                .withDefaultButtonFormatting()
                .padding(.horizontal, 40)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }
    }
}

#Preview {
    AnyTransitionLesson()
}
