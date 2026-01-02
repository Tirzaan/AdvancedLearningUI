//
//  CustomTabBarView.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 12/18/25.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        swithToTab(tab)
                    }
            }
        }
        .padding(6)
        .background(.white)
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(selection == tab ? tab.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.2) : tab.color.opacity(0.001))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func swithToTab(_ tab: TabBarItem) {
        withAnimation(.easeInOut) {
            selection = tab
        }
    }
}

struct TabBarItem: Hashable {
    let iconName: String
    let title: String
    let color: Color
}

#Preview {
    @Previewable @State var selection: TabBarItem = TabBarItem(iconName: "house", title: "Home", color: .red)
    
    @Previewable let tabs: [TabBarItem] = [
        TabBarItem(iconName: "house", title: "Home", color: .red),
        TabBarItem(iconName: "heart", title: "Favorites", color: .blue),
        TabBarItem(iconName: "person", title: "Profile", color: .green)
    ]
    
    VStack {
        Spacer()
        
        CustomTabBarView(tabs: tabs, selection: $selection)
    }
}
