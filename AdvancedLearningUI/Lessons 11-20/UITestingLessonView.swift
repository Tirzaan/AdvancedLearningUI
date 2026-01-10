//
//  UITestingLessonView.swift
//  AdvancedLearningUI
//
//  Created by Tirzaan on 1/7/26.
//

import SwiftUI
import Combine

@MainActor
final class UITestingLessonViewModel: ObservableObject {
    let placeholderTest: String = "Add your name..."
    @Published var textFieldText: String = ""
    @Published var userIsSignedIn: Bool = false
    
    init(userIsSignedIn: Bool = false) {
        self.userIsSignedIn = userIsSignedIn
    }
    
    func signUp() {
        guard !textFieldText.isEmpty else { return }
        userIsSignedIn = true
    }
}

struct UITestingLessonView: View {
    @StateObject private var viewModel:UITestingLessonViewModel
    
    init(userIsSignedIn: Bool) {
        _viewModel = StateObject(wrappedValue: UITestingLessonViewModel(userIsSignedIn: userIsSignedIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ZStack {
                if viewModel.userIsSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                } else {
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

extension UITestingLessonView {
    private var signUpLayer: some View {
        VStack {
            TextField(viewModel.placeholderTest, text: $viewModel.textFieldText)
                .font(.headline)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityIdentifier("Sign Up TextField")
            
            Button {
                withAnimation(.spring) {
                    viewModel.signUp()
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .accessibilityIdentifier("Sign Up Button")
            }
        }
        .padding()
    }
}

struct SignedInHomeView: View {
    @State private var path = NavigationPath()
    @State private var showAlert: Bool = false
    
    private enum Route: Hashable {
        case profile
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show Welcome Alert")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .accessibilityIdentifier("Show Welcome Alert Button")
                
                Button {
                    path.append(Route.profile)
                } label: {
                    Text("Profile")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .accessibilityIdentifier("Navigate to Profile Button")
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Welcome to the app!"))
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile:
                    Text("Profile Screen")
                        .font(.title)
                        .navigationTitle("Profile")
                }
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    UITestingLessonView(userIsSignedIn: false)
}
