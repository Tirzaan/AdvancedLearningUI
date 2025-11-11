//
//  CustomCurvedShapesLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/11/25.
//

import SwiftUI

// MARK: SHAPES
struct ArcSample: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(
                    center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.height / 2,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 40),
                    clockwise: true
                )
        }
    }
}

struct ShapeWithArc: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            // Top Left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            // Top Right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            // Mid Right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            // Bottom
//            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
            // Mid Left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct quadExample: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100)
            )
        }
    }
}

struct WaterShape: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            
            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40)
            )
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.60)
            )
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

// MARK: VIEWS
struct CustomCurvedShapesLesson: View {
    var body: some View {
        WaterShape()
            .fill(
                LinearGradient(
                    colors: [.teal, .blue, .blue, .indigo, .indigo],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
//            .stroke(lineWidth: 5)
//            .frame(width: 200, height: 200)
            .ignoresSafeArea()
    }
}

#Preview {
    CustomCurvedShapesLesson()
}
