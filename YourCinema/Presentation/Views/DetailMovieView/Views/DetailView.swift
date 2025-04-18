//
//  DetailView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 18.02.2025.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel(movieDetailUseCase: DetailMovieUseCase(repository: DetailMovieRepositoryImpl(networkManager: NetworkManager())))
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var appCoordinator: AppCoordinator
    
    @EnvironmentObject var imageViewModel: ImageViewModel
    
    let id: Int
    
    var body: some View {
            ZStack(alignment: .top) {
                if let image = viewModel.image {
                    GeometryReader { geometry in
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
                            .overlay(Image("detailMask"))
                            .ignoresSafeArea()
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    
                    if let movie = viewModel.movie {
                        Button {
                            if let videoURL = viewModel.movie?.videoURL, let url = URL(string: videoURL) {
                                UIApplication.shared.open(url)
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Image("play")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                        }
                        .padding(.bottom, 37)
                        
                        
                        Text("\(movie.ageRating ?? 0)+")
                            .customFont(type: .gilroyExtraBold, size: 20)
                            .foregroundColor(.white)
                            .padding(4)
                            .background(Color.black.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        Text(movie.name ?? "")
                            .customFont(type: .gilroyExtraBold, size: 40)
                            .foregroundStyle(.white)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Text(movie.genres.joined(separator: ", "))
                            .customFont(type: .gilroyRegular, size: 15)
                            .foregroundStyle(.mainRed)
                        
                        HStack {
                            Text("\(movie.year ?? 0),")
                                .customFont(type: .gilroyLight, size: 15)
                                .foregroundStyle(.white)
                            
                            Text(DurationFormatter.format(minutes: movie.movieLength ?? 0))
                                .customFont(type: .gilroyLight, size: 15)
                                .foregroundStyle(.white)
                        }
                        
                        Text("Storyline")
                            .customFont(type: .gilroyExtraBold, size: 16)
                            .foregroundStyle(.white)
                            .padding(.top, 52)
                        
                        Text(movie.description ?? "")
                            .customFont(type: .gilroyRegular, size: 15)
                            .foregroundStyle(.white)
                        
                        Text("Cast")
                            .customFont(type: .gilroyExtraBold, size: 16)
                            .foregroundStyle(.white)
                            .padding(.top, 24)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(movie.persons.filter { !$0.name.isEmpty }, id: \.id) { person in
                                    ActorView(viewModel: imageViewModel, person: person)
                                        .onTapGesture {
                                            appCoordinator.push(.actorDetails(person.id))
                                        }
                                }
                            }
                        }
                    } else {
                        ProgressView()
                            .scaleEffect(1.5)
                            .padding(.top, 50)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
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
            .onAppear {
                Task {
                    await viewModel.fetchDetailMovie(from: id)
                    if let imageUrl = viewModel.movie?.posterUrl {
                        viewModel.image = await imageViewModel.fetchImage(from: imageUrl)
                    }
                }
            }
            .background {
                Image("BG")
            }
    }
}
