//
//  ActorView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import SwiftUI

struct ActorView: View {
    @State private var actorImage: UIImage? = nil
    
    let viewModel: ImageViewModel
    let person: ActorEntity
    
    
    var body: some View {
        VStack {
            if let actorImage {
                Image(uiImage: actorImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            } else {
                ProgressView()
                    .frame(width: 80, height: 100)
                    .task {
                        actorImage = await viewModel.fetchImage(from: person.photo ?? "")
                    }
            }
            
            Text(person.name)
                .customFont(type: .gilroyExtraBold, size: 14)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
            
            Spacer()
            
            Text(person.description)
                .customFont(type: .gilroyExtraBold, size: 12)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
            
            Spacer()
            
        }
        .frame(width: 95, height: 190)
        .task {
            actorImage = await viewModel.fetchImage(from: person.photo ?? "")
        }
    }
}

