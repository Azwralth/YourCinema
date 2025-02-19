//
//  SearchTextField.swift
//  YourCinema
//
//  Created by Владислав Соколов on 17.02.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var isSearching = false
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isSearching.toggle()
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .cornerRadius(10)
            }
            
            TextField("Search...", text: $searchText)
                .textFieldStyle(.plain)
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .frame(width: isSearching ? (UIScreen.current?.bounds.width ?? 0) * 0.8 : 0)
                .opacity(isSearching ? 1 : 0)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}


extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


