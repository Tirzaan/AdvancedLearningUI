//
//  ContentView.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 11/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Button("1. Custom View Modifiers") {
                    path.append("Custom View Modifiers")
                }
                
                Button("2. Custom Button Styles") {
                    path.append("Custom Button Styles")
                }
                
                Button("3. Custom Transitions") {
                    path.append("Custom Transitions")
                }
                
                Button("4. Matched Geometry Effect") {
                    path.append("Matched Geometry Effect")
                }
                
                Button("5. Custom Shapes") {
                    path.append("Custom Shapes")
                }
                
                Button("6. Custom Curved Shapes") {
                    path.append("Custom Curved Shapes")
                }
                
                Button("7. Animateable Data With Shapes") {
                    path.append("Animateable Data With Shapes")
                }
                
                Button("8. Generics") {
                    path.append("Generics")
                }
                
                Button("9. View Builder") {
                    path.append("View Builder")
                }
                
                Button("10. Preference Key") {
                    path.append("Preference Key")
                }
                
                Button("Property Wrapper") {
                    path.append("Property Wrapper")
                }
                
                Button("Property Wrapper Implantation") {
                    path.append("Property Wrapper Implantation")
                }
            }
            .tint(.black)
            .navigationTitle("Lessons")
            .navigationDestination(for: String.self) { value in
                if value == "Custom View Modifiers" {
                    ViewModifierLesson()
                } else if value == "Custom Button Styles" {
                    ButtonStyleLesson()
                } else if value == "Custom Transitions" {
                    AnyTransitionLesson()
                } else if value == "Matched Geometry Effect" {
                    MatchedGeometryEffectLesson()
                } else if value == "Custom Shapes" {
                    CustomShapesLesson()
                } else if value == "Custom Curved Shapes" {
                    CustomCurvedShapesLesson()
                } else if value == "Animateable Data With Shapes" {
                    AnimateableDataWithShapes()
                } else if value == "Generics" {
                    GenericsLesson()
                } else if value == "View Builder" {
                    ViewBuilderLesson()
                } else if value == "Preference Key" {
                    ScrollViewOffsetPreferanceKeyLesson()
                } else if value == "Property Wrapper" {
                    PropertyWrapperLesson()
                } else if value == "Property Wrapper Implantation" {
                    PropertyWrapperImplantation()
                } else {
                    Text("Unknown Destination")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
