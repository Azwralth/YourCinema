//
//  MovieDetail.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import Foundation

struct MovieDetail: Decodable {
    let videos: Video?
    let ageRating: Int?
    let genres: [Genres]
    let name: String?
    let poster: Poster?
    let description: String?
    let persons: [Person]?
    let year: Int?
    let movieLength: Int?
}

struct Person: Decodable {
    let id: Int?
    let name: String?
    let photo: String?
    let description: String?
}

struct Video: Decodable {
    let trailers: [Trailer]?
}

struct Trailer: Decodable {
    let url: String?
}
