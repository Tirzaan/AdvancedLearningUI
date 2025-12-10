//
//  GeometryPrefereceKeyLession.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/26/25.
//

import SwiftUI

struct GeometryPrefereceKeyLession: View {
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(.blue)
            
            Spacer()
            
            HStack {
                Rectangle()
                
                GeometryReader { geo in
                    Rectangle()
                        .updateRectangleGeometrySize(geo.size)
                }
                
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePrefereceKey.self) { value in
            self.rectSize = value
        }
    }
}

#Preview {
    GeometryPrefereceKeyLession()
}

extension View {
    func updateRectangleGeometrySize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePrefereceKey.self, value: size)
    }
}

struct RectangleGeometrySizePrefereceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
