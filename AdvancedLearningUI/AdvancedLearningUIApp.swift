//
//  AdvancedLearningUIApp.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/6/25.
//

import SwiftUI

@main
struct AdvancedLearningUIApp: App {
    
    let currentUserIsSignedIn: Bool
    
    init() {
        let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        self.currentUserIsSignedIn = userIsSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
//            UITestingLessonView(userIsSignedIn: currentUserIsSignedIn)
            ContentView()
        }
    }
}
