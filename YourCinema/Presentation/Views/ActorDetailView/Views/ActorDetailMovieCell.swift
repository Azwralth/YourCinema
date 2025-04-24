//
//  ActorDetailMovieCell.swift
//  YourCinema
//
//  Created by Владислав Соколов on 26.02.2025.
//

import SwiftUI

struct ActorDetailMovieCell: View {
    @StateObject private var viewModel = DetailViewModel(movieDetailUseCase: DetailMovieUseCase(repository: DetailMovieRepositoryImpl(networkManager: NetworkManager())))
    
    @EnvironmentObject var imageViewModel: ImageViewModel
    
    let id: Int
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            } else {
                ProgressView()
                    .frame(height: 130)
            }
            
            Text(viewModel.movie?.name ?? "")
                .lineLimit(1)
                .customFont(type: .gilroyExtraBold, size: 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 9)
                .padding(.bottom, 6)
        }
        .background(Color.backgroundCell.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            Color.strokeCell.clipShape(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
        }
        .onAppear {
            Task {
                await viewModel.fetchDetailMovie(from: id)
                if let url = viewModel.movie?.posterUrl {
                    viewModel.image = await imageViewModel.fetchImage(from: url)
                }
            }
        }
    }
}
