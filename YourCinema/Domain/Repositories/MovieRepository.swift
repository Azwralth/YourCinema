//
//  MovieRepository.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

protocol MovieRepository {
    func fetchMovies() async throws -> [MovieEntity]
    func searchMovies(query: String) async throws -> [MovieEntity]
}
