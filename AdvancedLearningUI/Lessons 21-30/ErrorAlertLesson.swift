//
//  ErrorAlertLesson.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/19/26.
//

import SwiftUI

protocol AppAlert {
    var title: String { get }
    var message: String? { get }
    var buttons: AnyView { get }
}

extension View {
    func showCustomError(error: Binding<ErrorAlertLesson.MyCustomError?>, onOkPressed: @escaping () -> (), onRetryPressed: @escaping () -> (), onDeletePressed: @escaping () -> ()) -> some View {
        self
            .alert(error.wrappedValue?.localizedDescription ?? "Error", isPresented: Binding(value: error)) {
                error.wrappedValue?.getButtonsForError {
                    onOkPressed()
                } onRetryPressed: {
                    onRetryPressed()
                } onDeletePressed: {
                    onDeletePressed()
                }
            }
    }
    
    func showCustomAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert)) {
                alert.wrappedValue?.buttons
            } message: {
                if let message = alert.wrappedValue?.message {
                    Text(message)
                }
            }
    }
}

struct ErrorAlertLesson: View {
    @State private var error: MyCustomError? = nil
    @State private var alert: MyCustomAlert? = nil
    
    @State private var text: String = ""
    
    var body: some View {
        Button("Save Data (Error)") {
            saveDataWithError()
        }
        .showCustomError(error: $error, onOkPressed: {
            text = "OK (E)"
        }, onRetryPressed: {
            text = "Retried (E)"
        }, onDeletePressed: {
            text = "Deleted (E)"
        })
//        .alert(error?.localizedDescription ?? "ERROR", isPresented: Binding(value: $error)) {
//            error?.getButtonsForError {
//                text = "OK (E)"
//            } onRetryPressed: {
//                text = "Retried (E)"
//            } onDeletePressed: {
//                text = "Deleted (E)"
//            }
//        }
        .padding()
        
        Button("Save Data (Alert)") {
            saveDataWithAlert()
        }
        .showCustomAlert(alert: $alert)
//        .alert(alert?.title ?? "ERROR", isPresented: Binding(value: $alert), actions: {
//            alert?.getButtonsForAlert {
//                text = "OK (A)"
//            } onRetryPressed: {
//                text = "Retried (A)"
//            } onDeletePressed: {
//                text = "Deleted (A)"
//            }
//
//        }, message: {
//            if let message = alert?.message {
//                Text(message)
//            }
//        })
        .padding()
        
        Text(text)
    }
    
    enum MyCustomError: Error, LocalizedError {
        case noInternetConnect
        case dataNotFound
        case urlError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnect:
                "No internet connection, please check your internet connection and try again."
            case .dataNotFound:
                "Could not find data, please try again."
            case .urlError(error: let error):
                "Error: \(error.localizedDescription)"
            }
        }
        
        @ViewBuilder
        func getButtonsForError(onOkPressed: @escaping () -> (), onRetryPressed: @escaping () -> (), onDeletePressed: @escaping () -> ()) -> some View {
            switch self {
            case .noInternetConnect:
                Button("OK") {
                    onOkPressed()
                }
                Button("Retry") {
                    onRetryPressed()
                }
            case .dataNotFound:
                Button("OK") {
                    onOkPressed()
                }
                Button("Delete", role: .destructive) {
                    onDeletePressed()
                }
            case .urlError(_):
                Button("OK") {
                    onOkPressed()
                }
            }
        }
    }
    
    enum MyCustomAlert: Error, LocalizedError, AppAlert {
        case noInternetConnect
        case dataNotFound
        case urlError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnect:
                "No internet connection, please check your internet connection and try again."
            case .dataNotFound:
                "Could not find data, please try again."
            case .urlError(error: let error):
                "Error: \(error.localizedDescription)"
            }
        }
        
        var title: String {
            switch self {
            case .noInternetConnect:
                "No internet connection."
            case .dataNotFound:
                "Could not find data."
            case .urlError(error: _):
                "Error:"
            }
        }
        
        var message: String? {
            switch self {
            case .noInternetConnect:
                "please check your internet connection and try again."
            case .dataNotFound:
                nil
            case .urlError(error: let error):
                "\(error.localizedDescription)"
            }
        }
        
        @ViewBuilder
        func getButtonsForAlert(onOkPressed: @escaping () -> (), onRetryPressed: @escaping () -> (), onDeletePressed: @escaping () -> ()) -> some View {
            switch self {
            case .noInternetConnect:
                Button("OK") {
                    onOkPressed()
                }
                Button("Retry") {
                    onRetryPressed()
                }
            case .dataNotFound:
                Button("OK") {
                    onOkPressed()
                }
                Button("Delete", role: .destructive) {
                    onDeletePressed()
                }
            case .urlError(_):
                Button("OK") {
                    onOkPressed()
                }
            }
        }
        
        var buttons: AnyView {
            AnyView(getButtonsForAlert(onOkPressed: {
                
            }, onRetryPressed: {
                
            }, onDeletePressed: {
                
            }))
        }
    }
    
    func saveDataWithError() {
        let isSuccessful: Bool = false
        
        if isSuccessful {
            
        } else {
//            let myError: Error = URLError(.badURL)
            let noInternet: Bool = Bool.random()
            var myError: MyCustomError = MyCustomError.noInternetConnect
            if noInternet {
                myError = MyCustomError.noInternetConnect
            } else {
                let urlError: Bool = Bool.random()
                if urlError {
                    myError = MyCustomError.urlError(error: URLError(.badURL))
                } else {
                    myError = MyCustomError.dataNotFound
                }
            }
            
            error = myError
        }
    }
    
    func saveDataWithAlert() {
        let isSuccessful: Bool = false
        
        if isSuccessful {
            
        } else {
//            let myError: Error = URLError(.badURL)
            let noInternet: Bool = Bool.random()
            var myAlert: MyCustomAlert = MyCustomAlert.dataNotFound
            if noInternet {
                myAlert = MyCustomAlert.noInternetConnect
            } else {
                let urlError: Bool = Bool.random()
                if urlError {
                    myAlert = MyCustomAlert.urlError(error: URLError(.badURL))
                } else {
                    myAlert = MyCustomAlert.dataNotFound
                }
            }
            
            alert = myAlert
        }
    }
}

#Preview {
    ErrorAlertLesson()
}
