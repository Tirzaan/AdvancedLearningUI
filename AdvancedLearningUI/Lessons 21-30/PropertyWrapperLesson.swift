//
//  PropertyWrapperLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/29/26.
// 9:20

import SwiftUI

extension FileManager {
    static func documentsPath(_ key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    @State private var title: String
    let key: String
    var wrappedValue: String {
        get { title }
        nonmutating set { save(newValue) }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }
    }
    
    init(wrappedValue: String, _ key: String) {
        self.key = key
        do {
            title = try String(contentsOf: FileManager.documentsPath(key), encoding: .utf8)
            print("SUCCESS READING")
        } catch {
            title = wrappedValue
            print("ERROR READING: \(error)")
        }
    }
    
    func save(_ newValue: String) {
        do {
            /*
            // When atomically is set to true, the data is written to a temporary file first and then moved into place.
            // When atomically is set to false, the data is written directly to the specified file path.
             */
            try newValue.write(to: FileManager.documentsPath(key), atomically: true, encoding: .utf8)
            title = newValue
//            print(NSHomeDirectory())
            print("SUCCESS SAVING")
        } catch {
            print("ERROR SAVING: \(error)")
        }
    }
}

struct PropertyWrapperLesson: View {
//    @FileManagerProperty private var title: String
    @FileManagerProperty("custom_title_1") private var title: String = "Starting Text"
    @FileManagerProperty("custom_title_2") private var title2: String = "STARTING TEXT"
//    var fileManagerProperty = FileManagerProperty()
//    @State private var title = "Starting Title"
    @State private var subtitle: String = "Subtitle"
    
    var body: some View {
        VStack(spacing: 40) {
            Text(title)
                .font(.largeTitle)
            
            Button("Button 1") {
                title = "title 1"
            }
            .buttonStyle(.glassProminent)
            
            Button("Button 2") {
                title = "title 2"
            }
            .buttonStyle(.glassProminent)
            
            Divider()
            
            Text(title2)
                .font(.largeTitle)
            
            Button("Button 1") {
                title2 = "TITLE ONE"
            }
            .buttonStyle(.glassProminent)
            
            Button("Button 2") {
                title2 = "TITLE TWO"
            }
            .buttonStyle(.glassProminent)
            
            PropertyWrapperChildView(subtitle: $title2)
        }
    }
    /*
//    private func setTitle(_ newTitle: String) {
//        let uppercased = newTitle.uppercased()
//        title = uppercased
//        save(newValue: uppercased)
//    }
     */
}

struct PropertyWrapperChildView: View {
    @Binding var subtitle: String
    var body: some View {
        Button {
            subtitle = subtitle + "|"
        } label: {
            Text(subtitle)
                .font(.headline)
        }

    }
}

#Preview {
    PropertyWrapperLesson()
}
