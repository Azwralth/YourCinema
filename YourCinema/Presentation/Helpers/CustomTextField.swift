//
//  CustomTextField.swift
//  YourCinema
//
//  Created by Владислав Соколов on 07.02.2025.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var fieldModel: FieldModel
    
    var body: some View {
        TextField("", text: $fieldModel.value, prompt: Text(fieldModel.fieldType.placeholder)
            .foregroundColor(.gray.opacity(0.4))
        )
        .padding()
        .foregroundColor(.white)
        .customFont(type: .gilroyExtraBold)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(!fieldModel.value.isEmpty ? Color.mainRed.opacity(0.05) : Color.black.opacity(0.2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    !fieldModel.value.isEmpty ? Color.mainRed : Color.gray,
                    lineWidth: !fieldModel.value.isEmpty  ? 1 : 0
                )
        )
        .padding(.horizontal, 24)
    }
}
