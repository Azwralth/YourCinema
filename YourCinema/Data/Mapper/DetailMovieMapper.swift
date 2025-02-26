//
//  DetailMovieMapper.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import Foundation

final class DetailMovieMapper {
    static func map(movieDetail: MovieDetail) -> MovieDetailEntity {
        return MovieDetailEntity(
            videoURL: movieDetail.videos?.trailers?.first?.url ?? "",
            ageRating: movieDetail.ageRating ?? 0,
            genres: movieDetail.genres.map { $0.name },
            name: movieDetail.name ?? "",
            posterUrl: movieDetail.poster?.previewUrl ?? "",
            description: movieDetail.description ?? "",
            persons: movieDetail.persons?.map { PersonEntity(name: $0.name ?? "", photo: $0.photo ?? "", description: $0.description ?? "") } ?? [],
            year: movieDetail.year ?? 0,
            movieLength: movieDetail.movieLength ?? 0
        )
    }
}
