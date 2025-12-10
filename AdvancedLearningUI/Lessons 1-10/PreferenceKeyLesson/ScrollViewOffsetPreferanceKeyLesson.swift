//
//  ScrollViewOffsetPreferanceKeyLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 12/9/25.
//

import SwiftUI

struct ScrollViewOffsetPreferanceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> ()) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferanceKey.self, value: geo.frame(in: .global).minY)
                }
            )
            .onPreferenceChange(ScrollViewOffsetPreferanceKey.self) { value in
                action(value)
            }
    }
}

struct ScrollViewOffsetPreferanceKeyLesson: View {
    let title: String = "New Title"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(scrollViewOffset / 78.0)
                    .onScrollViewOffsetChanged { value in
                        self.scrollViewOffset = value
                    }
                
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(scrollViewOffset)"))
        .overlay (
            navBarLayer.opacity(scrollViewOffset < 40 ? 1.0 : 0)
                .animation(.spring(), value: scrollViewOffset)
                .transition(AnyTransition.move(edge: .top))
            , alignment: .top
        )
    }
}

extension ScrollViewOffsetPreferanceKeyLesson {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<100) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(.red/*.opacity(0.3)*/)
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue)
    }
}

#Preview {
    ScrollViewOffsetPreferanceKeyLesson()
}

//struct AlignToViewModifier: ViewModifier {
//    let alignment: Alignment
//    
//    func body(content: Content) -> some View {
//        content
//            .frame(
//                maxWidth: alignment == .leading ? .infinity : alignment == .trailing ? .infinity : nil,
//                alignment: alignment)
//    }
//}
//
//extension View {
//    func AlignTo(_ alignment: Alignment) -> some View {
//        modifier(AlignToViewModifier(alignment: alignment))
//    }
//}

