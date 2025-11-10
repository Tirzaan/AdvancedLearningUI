//
//  CustomShapesLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/10/25.
//

import SwiftUI

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
            
            Trapezoid()
                .frame(width: 300, height: 150)
        }
    }
}

#Preview {
    CustomShapesLesson()
}
