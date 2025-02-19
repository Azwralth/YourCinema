//
//  AuthView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 07.02.2025.
//

import SwiftUI

enum StartView {
    case login
    case registration
    case forgotPassword
}

struct AuthView: View {
    @StateObject var viewModel = AuthViewModel()

    var body: some View {
        AuthContainerView {
            changeStartView(viewModel.startView)
        }
    }
    
    @ViewBuilder
    func changeStartView(_ startView: StartView) -> some View {
        switch startView {
        case .login:
            LoginView(viewModel: viewModel)
        case .registration:
            RegistrationView(viewModel: viewModel)
        case .forgotPassword:
            ForgotPasswordView(viewModel: viewModel)
        }
    }
}

#Preview {
    AuthView()
}
