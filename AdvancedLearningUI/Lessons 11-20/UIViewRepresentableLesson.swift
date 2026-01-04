//
//  UIViewRepresentableLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 12/25/25.
//

import SwiftUI

// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableLesson: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            TextField("Type Here...", text: $text)
                .frame(height: 55)
                .background(Color.gray)
                .foregroundStyle(.green, .red, .yellow)
            
            UITextFieldViewRepresentable(text: $text)
                .updatePlaceholder("updated placeholder")
                .frame(height: 55)
                .background(Color.gray)
        }
    }
}

struct BasicUIViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    let placeholderColor: UIColor
    
    init(text: Binding<String>, placeholder: String = "Default Placeholder...", placeholderColor: UIColor = .red) {
        self._text = text
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = getTextField()
        textField.delegate = context.coordinator
        return textField
    }
    
    // from SwiftUI to UIKit
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func getTextField() -> UITextField {
        let textField = UITextField(frame: .zero)
        let placeHolder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor : placeholderColor
            ])
        
        textField.attributedPlaceholder = placeHolder
        return textField
    }
    
    func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
        var viewRepresentable = self
        viewRepresentable.placeholder = text
        return viewRepresentable
    }
    
    // from UIKit to SwiftUI
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
}

#Preview {
    UIViewRepresentableLesson()
}
