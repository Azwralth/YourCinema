//
//  Rating.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

struct Rating: Decodable, Hashable {
    let kp: Double?
    let imdb: Double?
    let filmCritics: Double?
    let russianFilmCritics: Double?
}
