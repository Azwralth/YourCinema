//
//  LoginView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        CustomTextField(fieldModel: $viewModel.loginEmailField)

        
        CustomTextField(fieldModel: $viewModel.loginPasswordField)
        CustomButton(title: "SIGN IN") {
            if viewModel.validateLoginFields() {
                print("Login")
            } else {
                print("❌ Validation failed!")
            }
        }

        HStack {
            Text("New at YourCinema?")
                .foregroundStyle(.gray)
                .customFont(type: .gilroyLight, size: 11)
            Button {
                withAnimation {
                    viewModel.startView = .registration
                }
            } label: {
                Text("Create Account")
                    .customFont(type: .gilroyLight, size: 11)
                    .foregroundStyle(.mainRed)
            }
        }
        .padding(.top, 26)
        .frame(height: 20)
        
        HStack {
            Text("Forgot your password?")
                .foregroundStyle(.gray)
                .customFont(type: .gilroyLight, size: 11)
            Button {
                withAnimation {
                    viewModel.startView = .forgotPassword
                }
            } label: {
                Text("Reset password")
                    .customFont(type: .gilroyLight, size: 11)
                    .foregroundStyle(.mainRed)
            }
        }
        .frame(height: 30)
    }
}
