//
//  AppTabBarView.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 12/18/25.
//

import SwiftUI

struct AppTabBarView: View {
    @State private var selection: String = "Home"
    
    var body: some View {
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag("Home")

            Color.blue
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag("Search")

            Color.orange
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag("Profile")
        }
    }
}

#Preview {
    AppTabBarView()
}
