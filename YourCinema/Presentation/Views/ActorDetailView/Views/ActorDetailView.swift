//
//  ActorDetailView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 25.02.2025.
//

import SwiftUI

struct ActorDetailView: View {
    @StateObject private var viewModel = ActorDetailViewModel(personDetailUseCase: PersonDetailUseCase(repository: PersonDetailRepositoryImpl(networkManager: NetworkManager())))
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @EnvironmentObject private var imageViewModel: ImageViewModel

    let id: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.32)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.7),
                                    Color.clear
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .overlay (
                            Color.black.opacity(0.7)
                        )
                        .overlay(
                            Image("detailMask")
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height / 1.3)
                        )
                        .ignoresSafeArea()
                }
                
                
                VStack(alignment: .leading) {
                                        
                    Text(viewModel.person?.name ?? "")
                        .customFont(type: .gilroyExtraBold, size: 44)
                        .foregroundStyle(.white.opacity(0.84))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: 16) {
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        } else {
                            ProgressView()
                                .frame(width: 80, height: 100)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(viewModel.person?.birthday ?? "")
                                .customFont(type: .gilroyRegular, size: 14)
                                .foregroundStyle(.white)
                            
                            Text(viewModel.person?.birthPlace?.joined(separator: ", ") ?? "")
                                .customFont(type: .gilroyRegular, size: 14)
                                .foregroundStyle(.white)
                            
                            Text(viewModel.person?.proffesion?.joined(separator: ", ") ?? "")
                                .customFont(type: .gilroyRegular, size: 14)
                                .foregroundStyle(.mainRed)
                            
                        }
                    }
                    
                    Text("Filmography")
                        .customFont(type: .gilroyExtraBold, size: 16)
                        .foregroundStyle(.white)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if let movieIds = viewModel.person?.movieId {
                                ForEach(Array(Set(movieIds)), id: \.self) { id in
                                    ActorDetailMovieCell(id: id)
                                        .frame(width: geometry.size.width / 3.6, height: geometry.size.height / 4.8)
                                        .onTapGesture {
                                            appCoordinator.push(.movieDetails(id))
                                        }
                                }
                            }
                        }
                    }
                    
                    Text("Biography")
                        .customFont(type: .gilroyExtraBold, size: 16)
                        .foregroundStyle(.white)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                    
                    Text("нет биографии")
                        .customFont(type: .gilroyLight, size: 16)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(.top, 96)
                .padding(.horizontal, 16)
            }
            .onAppear {
                Task {
                    await viewModel.fetchPersonDetail(from: id)
                    if let imageUrl = viewModel.person?.photo {
                        viewModel.image = await imageViewModel.fetchImage(from: imageUrl)
                    }
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
            }
            .background {
                Image("BG")
            }
        }
    }
}

//#Preview {
//    ActorDetailView(person: ActorEntity(name: "Гари Льюис", photo: "https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/29216b67-ec98-4c58-b47e-0e22dcee12f6/orig", description: ""), id: 13434)
//        .environmentObject(ImageViewModel(imageRepository: ImageRepositoryImpl(networkManager: NetworkImageManager())))
//}
