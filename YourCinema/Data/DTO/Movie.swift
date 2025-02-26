//
//  Movie.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

struct Movie: Decodable, Hashable {
    let id: Int?
    let name: String?
    let movieLength: Int?
    let description: String?
    let poster: Poster?
    let ageRating: Int?
    let genres: [Genres]
}
