//
//  MovieView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

struct MovieView: View {
    @StateObject private var viewModel = MovieViewModel(
        fetchMoviesUseCase: FetchMoviesUseCase(repository: MovieRepositoryImpl(networkManager: NetworkManager())),
        searchMoviesUseCase: SearchMoviesUseCase(repository: MovieRepositoryImpl(networkManager: NetworkManager()))
    )

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.mainBackground.opacity(0.91).ignoresSafeArea()

                if viewModel.movies.isEmpty {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            .scaleEffect(2)
                        Text("Загрузка фильмов...")
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.movies, id: \.self) { movie in
                                NavigationLink {
                                    DetailView(videoURL: "", ageRating: movie.ageRating ?? 0, genres: movie.genres.first ?? "", nameMovie: movie.title, urlImage: movie.posterUrl ?? "", description: movie.description)
                                } label: {
                                    MovieCell(movie: movie, imageRepository: ImageRepositoryImpl(networkManager: NetworkManager()))
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.bottom, 10)
                    }
                    .refreshable {
                        await viewModel.fetchMovies()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    SearchView(searchText: $viewModel.searchText)
                }
            }
        }
    }
}


#Preview {
    MovieView()
}
