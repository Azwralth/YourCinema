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
                }
                
                TextField("Search...", text: $searchText)
                    .textFieldStyle(.plain)
                    .padding(8)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .frame(width: isSearching ? UIApplication.shared.screenWidth * 0.8 : 0)
                    .opacity(isSearching ? 1 : 0)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    SearchView(searchText: .constant(""))
        .padding()
}


