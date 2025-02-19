//
//  ValidationService.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import Foundation

struct FieldModel {
    var value: String
    var error: String?
    var fieldType: FieldType
    
    init(value: String, error: String? = nil, fieldType: FieldType) {
        self.value = value
        self.error = error
        self.fieldType = fieldType
    }
    
    mutating func validate(confirmPassword: String? = nil) -> Bool {
        error = fieldType.validate(value: value, confirmPassword: confirmPassword)
        return error == nil
    }
    
    mutating func validateOnSubmit(confirmPassword: String? = nil) {
        error = fieldType.validate(value: value, confirmPassword: confirmPassword)
    }
}


protocol FieldValidatorProtocol {
    func validate(value: String) -> String?
}

enum FieldType {
    case email
    case password
    case confirmPassword
    
    var placeholder: String {
        switch self {
        case .email: return "Enter your email"
        case .password: return "Enter your password"
        case .confirmPassword: return "Confirm your password"
        }
    }
    
    func validate(value: String, confirmPassword: String? = nil) -> String? {
        switch self {
        case .email:
            return emailValidate(value: value)
        case .password:
            return passwordValidate(value: value)
        case .confirmPassword:
            return confirmPasswordValidate(value: value, confirmPassword: confirmPassword)
        }
    }
    
    private func emailValidate(value: String) -> String? {
        guard !value.isEmpty else { return "Please enter your email" }
        
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: value) ? nil : "Invalid email format"
    }
    
    private func passwordValidate(value: String) -> String? {
        guard !value.isEmpty else { return "Please enter your password" }
        return nil
    }
    
    private func confirmPasswordValidate(value: String, confirmPassword: String?) -> String? {
        guard !value.isEmpty else { return "Please confirm your password" }
        guard value == confirmPassword else { return "Passwords do not match" }
        return nil
    }
}


