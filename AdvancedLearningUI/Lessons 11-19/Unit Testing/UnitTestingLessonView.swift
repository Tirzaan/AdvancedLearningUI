//
//  UnitTestingLessonView.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/5/26.
//

// Unit Tests
/*
 - Tests the background logic of your app
 */

// UI Tests
/*
 - Tests the UI of your app
 */

import SwiftUI

struct UnitTestingLessonView: View {
    @StateObject private var viewModel: UnitTestingLessonViewModel
    
    init(isPremium: Bool) {
        _viewModel = StateObject(wrappedValue: UnitTestingLessonViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(viewModel.isPremium.description)
    }
}

#Preview {
    UnitTestingLessonView(isPremium: true)
}
