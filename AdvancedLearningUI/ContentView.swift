//
//  ContentView.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/6/25.
//

import SwiftUI

struct MGIImage: View {
    let category: String
    let imageName: String
    let aspectContentMode: ContentMode = .fill
    
    var body: some View {
        AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/fun-with-languages.firebasestorage.app/o/Images%2FMatchingGame%2F\(category)%2FMGI-945-\(imageName).png?alt=media&token=2c503f6f-d1e0-4415-a8ab-b9d2d5be608c")) { image in
            if let image = image.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: aspectContentMode)
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
//        NavigationStack {
//            List {
//                NavigationLink("Custom View Modifiers") {
//                    ViewModifierLesson()
//                }
//                
//                NavigationLink("Custom Button Styles") {
//                    ButtonStyleLesson()
//                }
//            }
//        }
        
        MGIImage(category: "Animals", imageName: "Fish")
            .frame(width: 400, height: 400)
    }
}

#Preview {
    ContentView()
}
