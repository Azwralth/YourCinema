//
//  CustomButton.swift
//  YourCinema
//
//  Created by Владислав Соколов on 07.02.2025.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(.white)
                .customFont(type: .gilroyExtraBold, size: 12)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.mainPurple, .mainRed]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(24)
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    CustomButton(title: "SIGN IN", action: {})
}
