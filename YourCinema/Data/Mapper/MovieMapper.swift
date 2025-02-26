//
//  MovieMapper.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import Foundation

final class MovieMapper {
    static func map(movie: Movie) -> MovieEntity {
        return MovieEntity(
            id: movie.id ?? 0,
            title: movie.name ?? "Нет названия",
            duration: movie.movieLength,
            description: movie.description ?? "Описание отсутствует",
            posterUrl: movie.poster?.previewUrl,
            ageRating: movie.ageRating,
            genres: movie.genres.map { $0.name }
        )
    }
    
    static func map(movies: [Movie]) -> [MovieEntity] {
        return movies.map { map(movie: $0) }
    }
}
