//
//  AuthContainerView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

struct AuthContainerView<Content: View>: View {
    
    let content: () -> Content
    
    @FocusState private var isTextFieldFocused: Bool
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9)
                .ignoresSafeArea()
            
            Image("mainBackground")
                .resizable()
                .ignoresSafeArea()
                .onTapGesture { hideKeyboard() }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Your")
                    .customFont(type: .gilroyExtraBold, size: 60)
                    .foregroundStyle(.white)
                Text("Cinema")
                    .customFont(type: .gilroyExtraBold, size: 60)
                    .foregroundStyle(
                        LinearGradient(colors: [.mainPurple, .mainRed], startPoint: .leading, endPoint: .trailing)
                    )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.bottom, 160)
            .opacity(isTextFieldFocused ? 0 : 1)
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    content()
                        .focused($isTextFieldFocused)
                }
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
                .background(
                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundStyle(.black.opacity(0.25))
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }
                )
            }
            .ignoresSafeArea(.container)
        }
        
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
