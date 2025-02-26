//
//  MovieViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import UIKit
import Combine

final class MovieViewModel: ObservableObject {
    @Published var movies: [MovieEntity] = []
    @Published var error: NetworkError?
    @Published var searchText = ""

    private let fetchMoviesUseCase: MainMoviesUseCase
    private let searchMoviesUseCase: SearchMoviesUseCase
    private var cancellables = Set<AnyCancellable>()

    init(fetchMoviesUseCase: MainMoviesUseCase, searchMoviesUseCase: SearchMoviesUseCase) {
        self.fetchMoviesUseCase = fetchMoviesUseCase
        self.searchMoviesUseCase = searchMoviesUseCase

        Task {
            await fetchMovies()
        }

        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] newValue in
                guard let self = self else { return }
                Task {
                    if newValue.isEmpty {
                        await self.fetchMovies()
                    } else {
                        await self.fetchSearchMovie()
                    }
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    func fetchSearchMovie() async {
        do {
            movies = try await searchMoviesUseCase.execute(query: searchText)
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknownError(0)
        }
    }

    @MainActor
    func fetchMovies() async {
        do {
            movies = try await fetchMoviesUseCase.execute()
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknownError(0)
        }
    }
}


