//
//  DetailMovieRepositoryImpl.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import Foundation

final class DetailMovieRepositoryImpl: MovieDetailRepository {
    private let networkManager: ServerApi

    init(networkManager: ServerApi) {
        self.networkManager = networkManager
    }
    
    func fetchDetailMovie(from id: Int) async throws -> MovieDetailEntity {
        let detailMovie = try await networkManager.fetch(type: MovieDetail.self, from: CinemaId(id: id))
        return DetailMovieMapper.map(movieDetail: detailMovie)
    }
}
