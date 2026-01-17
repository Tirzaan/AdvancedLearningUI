//
//  TimelineViewLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/16/26.
//

import SwiftUI

struct TimelineViewLesson: View {
    
    @State var startTime: Date = .now
    @State var isPaused: Bool = false
    
    var body: some View {
        VStack {
            TimelineView(.animation(minimumInterval: 1, paused: isPaused)) { context in
                Text("\(context.date)")
                Text("\(context.date.timeIntervalSince1970)")
                
//                let seconds = Calendar.current.component(.second, from: context.date)
                let seconds = context.date.timeIntervalSince(startTime)
                Text("\(seconds)")
                
                if context.cadence == .live {
                    Text("Cadence: Live")
                } else if context.cadence == .minutes {
                    Text("Cadence: Minutes")
                } else if context.cadence == .seconds {
                    Text("Cadence: Seconds")
                }
                
                Rectangle()
                    .frame(width: seconds < 10 ? 50 : seconds < 30 ? 200 : 400, height: 100)
                    .animation(.spring(bounce: 0.5), value: seconds)
            }
            
            Button("Pause / Resume") {
                isPaused.toggle()
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .padding()
        }
    }
}

#Preview {
    TimelineViewLesson()
}
