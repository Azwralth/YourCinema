//
//  MovieDetailEntity.swift
//  YourCinema
//
//  Created by Владислав Соколов on 20.02.2025.
//

struct MovieDetailEntity: Hashable {
    let videoURL: String?
    let ageRating: Int?
    let genres: [String]
    let name: String?
    let posterUrl: String?
    let description: String?
    let persons: [PersonEntity]
    let year: Int?
    let movieLength: Int?
}
