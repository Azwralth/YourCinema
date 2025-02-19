//
//  AuthViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import Foundation

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
    
    @Published var startView: StartView = .login

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


