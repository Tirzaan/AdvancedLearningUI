//
//  ProtocolsLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/3/26.
//

import SwiftUI

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternateColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .black
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color = .red
    var tertiary: Color = .purple
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {
    
}

class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Protocols are awesome!"
    
    func buttonPressed() {
        print("Button was pressed!")
    }
}

class AlternateDataSource: ButtonTextProtocol {
    var buttonText: String = "Protocols are lame!"
    
    func buttonPressed() {
        print("Alternate button was pressed!")
    }
}

struct ProtocolsLesson: View {
    let colorTheme: ColorThemeProtocol = DefaultColorTheme()
    let colorTheme2: ColorThemeProtocol = AlternateColorTheme()
    let setColorTheme: ColorThemeProtocol
    
    let dataSource: ButtonDataSourceProtocol
    
    @State private var usingColorTheme1: Bool = true
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(usingColorTheme1 ? colorTheme.tertiary : colorTheme2.tertiary)
                .ignoresSafeArea()
                .overlay(alignment: .top) {
                    VStack {
                        Text("Set Color Theme:")
                            .padding(8)
                            .background(.teal)
                            .padding(.top, 1)
                        
                        HStack {
                            Rectangle()
                                .fill(setColorTheme.primary)
                            
                            Rectangle()
                                .fill(setColorTheme.secondary)
                            
                            Rectangle()
                                .fill(setColorTheme.tertiary)
                        }
                        .frame(height: 55)
                        .padding()
                        .background(.teal)
                    }
                }
            
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(usingColorTheme1 ? colorTheme.secondary : colorTheme2.secondary)
                .padding()
                .background(usingColorTheme1 ? colorTheme.primary : colorTheme2.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    usingColorTheme1.toggle()
                    dataSource.buttonPressed()
                }
        }
    }
}
    
#Preview {
    ProtocolsLesson(setColorTheme: AnotherColorTheme(), dataSource: DefaultDataSource())
}
