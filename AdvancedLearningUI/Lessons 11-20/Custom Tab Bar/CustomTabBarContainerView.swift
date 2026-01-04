//
//  CustomTabBarContainerView.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 12/20/25.
//

import SwiftUI
import Combine

struct CustomTabBarContainerView<Content: View> : View {
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
    }
}

#Preview {
    @Previewable @State var selection: TabBarItem = TabBarItem(iconName: "house", title: "Home", color: .red)
    
    @Previewable let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home", color: .red),
        TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
        TabBarItem(iconName: "person", title: "Profile", color: .green)
    ]
    
    CustomTabBarContainerView(selection: $selection) {
        Color.red
    }
}
