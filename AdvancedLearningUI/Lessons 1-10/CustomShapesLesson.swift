//
//  CustomShapesLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/10/25.
//

import SwiftUI

struct A_Shape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // MARK: - Define relative points for flexibility
        let width = rect.width
        let height = rect.height
        
        // Coordinates are normalized so the shape scales properly.
        let top = CGPoint(x: 0.5 * width, y: 0.0)             // Top point of "A"
        let bottomLeft = CGPoint(x: 0.1 * width, y: height)   // Bottom left leg
        let bottomRight = CGPoint(x: 0.9 * width, y: height)  // Bottom right leg
        let crossbarLeft = CGPoint(x: 0.3 * width, y: 0.55 * height)
        let crossbarRight = CGPoint(x: 0.7 * width, y: 0.55 * height)
        let innerLeft = CGPoint(x: 0.4 * width, y: 0.4 * height)
        let innerRight = CGPoint(x: 0.6 * width, y: 0.4 * height)
        
        // MARK: - Draw outer "A" triangle shape
        path.move(to: bottomLeft)
        path.addLine(to: top)
        path.addLine(to: bottomRight)
        path.addLine(to: CGPoint(x: 0.78 * width, y: 0.75 * height))
        path.addLine(to: CGPoint(x: 0.22 * width, y: 0.75 * height))
        path.closeSubpath()
        
        // MARK: - Subtract the "hole" inside the A
        var innerPath = Path()
        innerPath.move(to: innerLeft)
        innerPath.addLine(to: crossbarLeft)
        innerPath.addLine(to: crossbarRight)
        innerPath.addLine(to: innerRight)
        innerPath.closeSubpath()
        
        // Combine main path minus inner
        path.addPath(innerPath)
        
        return path
    }
}

struct Triangle: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Diamond: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
        }
    }
}

struct CustomShapesLesson: View {
    var body: some View {
        ZStack {
//            Image("Sinterklaas")
//                .resizable()
//                .scaledToFill()
//                .frame(width: 300, height: 300)
//                .clipShape(
//                    Triangle()
//                        .rotation(Angle(degrees: 180))
//                )
            
//            Triangle()
//                .frame(width: 300, height: 300)
//                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, dash: [10]))
//                .foregroundStyle(.blue)
//                .fill(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
//                .trim(from: 0, to: 0.5)
            
//            Diamond()
//                .frame(width: 300, height: 300)
            
//            Trapezoid()
//                .frame(width: 300, height: 150)
            
            A_Shape()
                .frame(width: 300, height: 300)
        }
    }
}

#Preview {
    CustomShapesLesson()
}
