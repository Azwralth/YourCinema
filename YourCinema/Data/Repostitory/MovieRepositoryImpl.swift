//
//  MovieRepositoryImpl.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

final class MovieRepositoryImpl: MovieRepository {
    private let networkManager: ServerApi

    init(networkManager: ServerApi) {
        self.networkManager = networkManager
    }

    func fetchMovies() async throws -> [MovieEntity] {
        let response = try await networkManager.fetch(type: MovieResponse.self, from: MainViewCinema(page: Int.random(in: 1...10)))
        return MovieMapper.map(movies: response.docs)
    }

    func searchMovies(query: String) async throws -> [MovieEntity] {
        let response = try await networkManager.fetch(type: MovieResponse.self, from: SearchCinema(name: query))
        return MovieMapper.map(movies: response.docs)
    }
}
