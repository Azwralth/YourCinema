//
//  MovieView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 10.02.2025.
//

import SwiftUI

struct MovieView: View {
    @StateObject private var viewModel = MovieViewModel(
        fetchMoviesUseCase: MainMoviesUseCase(repository: MovieRepositoryImpl(networkManager: NetworkManager())),
        searchMoviesUseCase: SearchMoviesUseCase(repository: MovieRepositoryImpl(networkManager: NetworkManager()))
    )
    
    @EnvironmentObject var imageViewModel: ImageViewModel

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
                                    DetailView(id: movie.id)
                                } label: {
                                    MovieCell(movie: movie)
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
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
