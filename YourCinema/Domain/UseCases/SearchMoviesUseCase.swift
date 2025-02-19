//
//  SearchMoviesUseCase.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import Foundation

final class SearchMoviesUseCase {
    private let repository: MovieRepository

    init(repository: MovieRepository) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [MovieEntity] {
        let movies = try await repository.searchMovies(query: query)
        return movies
    }
}
