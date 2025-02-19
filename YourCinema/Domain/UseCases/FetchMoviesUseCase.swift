//
//  FetchMoviesUseCase.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import Foundation

final class FetchMoviesUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute() async throws -> [MovieEntity] {
        let movies = try await repository.fetchMovies()
        return movies
    }
}
