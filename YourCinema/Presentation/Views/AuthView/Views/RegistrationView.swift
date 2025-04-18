//
//  RegistrationView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

struct RegistrationView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        CustomTextField(fieldModel: $viewModel.registerEmailField, isSecure: false)
        CustomTextField(fieldModel: $viewModel.registerPasswordField, isSecure: true)
        CustomTextField(fieldModel: $viewModel.registerConfirmPasswordField, isSecure: true)
        CustomButton(title: "CREATE ACCOUNT") {
            if viewModel.validateRegistrationFields() {
                Task { await viewModel.register() }
            } else {
                print("Validation failed!")
            }
        }
        HStack {
            Text("Already have an account?")
                .foregroundStyle(.gray)
                .customFont(type: .gilroyLight, size: 11)
            Button {
                withAnimation {
                    viewModel.startView = .login
                }
            } label: {
                Text("Sign In")
                    .customFont(type: .gilroyLight, size: 11)
                    .foregroundStyle(.mainRed)
            }
        }
        .padding(.top, 26)
        .frame(height: 30)
    }
}
