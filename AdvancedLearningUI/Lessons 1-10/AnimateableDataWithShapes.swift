//
//  AnimateableDataWithShapes.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/11/25.
//

import SwiftUI

struct RectangleWithSingleCornerAnimation: Shape {
    var cornerRadius: CGFloat
    
    var animatableData: CGFloat {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minX))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxX - cornerRadius))
            path.addArc(
                center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxX - cornerRadius),
                radius: cornerRadius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 360),
                clockwise: false
            )
            
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxX))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxX))
            path.move(to: .zero)
        }
    }
}

struct Packman: Shape {
    var offsetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { offsetAmount }
        set { offsetAmount = newValue }
    }

    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: offsetAmount),
                endAngle: Angle(degrees: 360 - offsetAmount),
                clockwise: false
            )
        }
    }
}

struct AnimateableDataWithShapes: View {
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: animate ? 60 : 0)
//            RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
            Packman(offsetAmount: animate ? 30 : 0)
                .fill(.yellow)
                .frame(width: 250, height: 250)
        }
        .onAppear {
            withAnimation(.linear(duration: 0.25).repeatForever()) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    AnimateableDataWithShapes()
}
