//
//  AuthViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    // Поля для Login
    @Published var loginEmailField = FieldModel(value: "", fieldType: .email)
    @Published var loginPasswordField = FieldModel(value: "", fieldType: .password)
    
    // Поля для Registration
    @Published var registerEmailField = FieldModel(value: "", fieldType: .email)
    @Published var registerPasswordField = FieldModel(value: "", fieldType: .password)
    @Published var registerConfirmPasswordField = FieldModel(value: "", fieldType: .confirmPassword)
    
    // Поля для Forgot Password
    @Published var forgotEmailField = FieldModel(value: "", fieldType: .email)
    
    @Published var isAuthenticated = false
    
    @Published var startView: StartView = .login
    
    @Published var errorMessage: String = ""
    
    @Published var isAlertPresented = false
    
    var isForgotPasswordButtonDisabled: Bool {
        forgotEmailField.value.isEmpty
    }
    
    private let authService: AuthenticationManagerProtocol
    
    init(authService: AuthenticationManagerProtocol) {
        self.authService = authService
    }
    
    func login() async {
        guard validateLoginFields() else { return }
        
        do {
            try await authService.signIn(email: loginEmailField.value, password: loginPasswordField.value)
            isAuthenticated = true
        } catch {
            print("error login")
        }
    }
    
    func register() async {
        do {
            try await authService.signUp(email: registerEmailField.value, password: registerPasswordField.value)
            isAuthenticated = true
        } catch {
            print("error register")
            isAuthenticated = false
        }
    }
    
    func forgotPassword() async {
        do {
            try await authService.resetPassword(email: forgotEmailField.value)
        } catch {
            print("error reset password")
        }
    }
    
    func loginTapped(navigationHandler: @escaping () -> Void) {
        guard validateLoginFields() else {
            errorMessage = "Email or password is invalid."
            return
        }
        
        Task {
            await login()
            
            if isAuthenticated {
                withAnimation {
                    navigationHandler()
                }
            }
        }
    }
    
    func registrationTapped(navigationHandler: @escaping () -> Void) {
        guard validateRegistrationFields() else {
            errorMessage = "Email or password is invalid."
            return
        }
        
        Task {
            await register()
            
            if isAuthenticated {
                withAnimation {
                    navigationHandler()
                }
            }
        }
    }
    
    func forgotPasswordTapped() {
        guard validateForgotPasswordFields() else { return }
        
        Task {
            await forgotPassword()
        }
    }
    

    // Валидация для Login
    func validateLoginFields() -> Bool {
        let isEmailValid = loginEmailField.validate()
        let isPasswordValid = loginPasswordField.validate()
        return isEmailValid && isPasswordValid
    }

    // Валидация для Registration
    func validateRegistrationFields() -> Bool {
        let isEmailValid = registerEmailField.validate()
        let isPasswordValid = registerPasswordField.validate()
        let isConfirmValid = registerConfirmPasswordField.validate(confirmPassword: registerPasswordField.value)
        return isEmailValid && isPasswordValid && isConfirmValid
    }

    // Валидация для Forgot Password
    func validateForgotPasswordFields() -> Bool {
        return forgotEmailField.validate()
    }
}


