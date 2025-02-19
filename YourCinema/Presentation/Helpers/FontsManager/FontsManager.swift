//
//  FontsManager.swift
//  YourCinema
//
//  Created by Владислав Соколов on 07.02.2025.
//

import SwiftUI

enum FontManager: String {
    case gilroyExtraBold = "Gilroy-ExtraBold"
    case gilroyLight = "Gilroy-Light"
    case gilroyRegular = "Gilroy-Regular"
}

extension View {
    func customFont(type: FontManager, size: CGFloat = 14) -> some View {
        modifier(CustomFont(font: type, size: size))
    }
}

struct CustomFont: ViewModifier {
    var font: FontManager
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
    }
}
