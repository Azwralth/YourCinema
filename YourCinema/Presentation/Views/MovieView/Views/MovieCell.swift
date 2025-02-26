//
//  MovieCell.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

struct MovieCell: View {
    @StateObject var viewModel = ImageViewModel(imageRepository: ImageRepositoryImpl(networkManager: NetworkImageManager()))
    @State private var image: UIImage? = nil
    
    let movie: MovieEntity
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 250)
                    .overlay {
                        Image("mask").resizable()
                    }
                    .overlay(alignment: .topLeading) {
                        Text("\(movie.ageRating ?? 0)+")
                            .customFont(type: .gilroyExtraBold, size: 25)
                            .foregroundColor(.white)
                            .padding([.vertical, .horizontal], 4)
                            .background(Color.black.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(15)
                    }
                    .overlay(alignment: .bottomLeading) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(movie.genres.first ?? "")
                                .customFont(type: .gilroyRegular, size: 15)
                                .foregroundStyle(.mainRed)
                                .padding(.leading, 12)
                        }
                    }
            } else {
                ProgressView().frame(height: 250)
            }
            
            VStack(spacing: 8) {
                Text(movie.title)
                    .lineLimit(1)
                    .customFont(type: .gilroyExtraBold, size: 19)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white.opacity(0.8))
                
                Text(DurationFormatter.format(minutes: movie.duration ?? 0))
                    .customFont(type: .gilroyExtraBold, size: 17)
                    .foregroundStyle(.gray.opacity(0.8))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
            }
            .padding(.leading, 13)
        }
        .onAppear {
            Task {
                if let url = movie.posterUrl {
                    image = await viewModel.fetchImage(from: url)
                }
            }
        }
        .background(Color.backgroundCell.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            Color.strokeCell.clipShape(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
        }
    }
}
