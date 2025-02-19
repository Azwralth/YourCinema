//
//  ForgotPasswordView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        Text("Forgot your password?")
            .customFont(type: .gilroyExtraBold, size: 20)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 24)
        Text("Tell us your email address, and we’ll get you back on trak in no time")
            .customFont(type: .gilroyExtraBold, size: 14)
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 24)
            .padding(.trailing, 70)
        CustomTextField(fieldModel: $viewModel.forgotEmailField)
        CustomButton(title: "RESET PASSWORD") {
            if viewModel.validateForgotPasswordFields() {
                print("Login")
            } else {
                print("❌ Validation failed!")
            }
        }
        HStack {
            Text("Back to")
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
