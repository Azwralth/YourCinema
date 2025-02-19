//
//  DetailView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 18.02.2025.
//

import SwiftUI
import AVKit
import UIKit

struct DetailView: View {
    let videoURL: String
    let ageRating: Int
    let genres: String
    let nameMovie: String
    let urlImage: String
    let description: String

    @StateObject var viewModel = DetailViewModel(imageRepository: CachedImageRepository(networkManager: NetworkManager()))
    @State private var isShowingVideo = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.7),
                                Color.black.opacity(0.7),
                                Color.black.opacity(0.7),
                                Color.black.opacity(0.7)
                            ]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .overlay(
                        Image("detailMask")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.6)
                    )
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 8) {
                Spacer()
                
                Button {
                    isShowingVideo = true
                } label: {
                    Image("play")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 37)
                
                Text("\(ageRating)+")
                    .customFont(type: .gilroyExtraBold, size: 20)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(nameMovie)
                    .customFont(type: .gilroyExtraBold, size: 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .foregroundStyle(.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(genres)
                    .customFont(type: .gilroyRegular, size: 15)
                    .foregroundStyle(.mainRed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                Text("Storyline")
                    .customFont(type: .gilroyExtraBold, size: 16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 52)
                
                Text(description)
                    .customFont(type: .gilroyRegular, size: 15)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                Text("Cast")
                    .customFont(type: .gilroyExtraBold, size: 16)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<4) { _ in
                            VStack {
                                Image("actor")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                Text("Chris Hemsworth")
                                    .customFont(type: .gilroyExtraBold, size: 16)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 90, height: 140)
                        }
                    }
                }
                .padding(.horizontal, 10)
                
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.gray)
                        Text("Back")
                            .foregroundStyle(.gray)
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image("likeFill")
                        .resizable()
                        .frame(width: 25, height: 22)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage(from: urlImage)
            }
        }
        .background {
            Image("BG")
        }
        .fullScreenCover(isPresented: $isShowingVideo) {
            VideoPlayerView(videoURL: videoURL)
        }
    }
}


#Preview {
    DetailView(videoURL: "https://www.youtube.com/embed/ZsJz2TJAPjw", ageRating: 13, genres: "Комедия", nameMovie: "Невезучие", urlImage: "https://image.openmoviedb.com/kinopoisk-images/10835644/97961e3e-4f26-4ebf-b2a6-24594252e65e/orig", description: "After the devastating events of Avengers: Infinity War, the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos' actions and restore balance to the universe.")
}
