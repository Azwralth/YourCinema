//
//  AuthenticationManager.swift
//  YourCinema
//
//  Created by Владислав Соколов on 15.04.2025.
//

import FirebaseAuth

protocol AuthenticationManagerProtocol {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func resetPassword(email: String) async throws
}

final class AuthenticationManager: AuthenticationManagerProtocol {
    
    func signIn(email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    func signUp(email: String, password: String) async throws {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            throw error
        }
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            throw error
        }
    }
}

