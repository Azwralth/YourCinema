//
//  DetailMovieUseCase.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import Foundation

final class DetailMovieUseCase {
    private let repository: MovieDetailRepository
    
    init(repository: MovieDetailRepository) {
        self.repository = repository
    }
    
    func execute(_ id: Int) async throws -> MovieDetailEntity {
        let detailMovie = try await repository.fetchDetailMovie(from: id)
        return detailMovie
    }
}
