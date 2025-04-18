//
//  AuthViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import Foundation


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
    
    private let authService: AuthenticationManagerProtocol
    
    init(authService: AuthenticationManagerProtocol) {
        self.authService = authService
    }
    
    
    func login() async {
        guard validateLoginFields() else { return }
        
        do {
            try await authService.signIn(email: loginEmailField.value, password: loginPasswordField.value)
            
            await MainActor.run {
                self.isAuthenticated = true
            }
        } catch {
            
        }
    }
    
    func register() async {
        guard validateRegistrationFields() else { return }
        
        do {
            try await authService.signUp(email: registerEmailField.value, password: registerPasswordField.value)
        } catch {
            
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


