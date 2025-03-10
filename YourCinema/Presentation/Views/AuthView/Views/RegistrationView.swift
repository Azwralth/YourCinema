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
        CustomTextField(fieldModel: $viewModel.registerEmailField)
        CustomTextField(fieldModel: $viewModel.registerPasswordField)
        CustomTextField(fieldModel: $viewModel.registerConfirmPasswordField)
        CustomButton(title: "CREATE ACCOUNT") {
            if viewModel.validateRegistrationFields() {
                print("Login")
            } else {
                print("❌ Validation failed!")
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
