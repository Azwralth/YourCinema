//
//  MovieDetailRepository.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import Foundation

protocol MovieDetailRepository {
    func fetchDetailMovie(from id: Int) async throws -> MovieDetailEntity
}
