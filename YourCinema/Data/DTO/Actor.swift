//
//  Actor.swift
//  YourCinema
//
//  Created by Владислав Соколов on 26.02.2025.
//

import Foundation

struct Actor: Decodable {
    let id: Int
    let name: String?
    let photo: String?
    let birthday: String?
    let profession: [Profession]?
    let birthPlace: [BirthPlace]?
    let movies: [ActorMovies]
}

struct ActorMovies: Decodable {
    let id: Int?
}

struct Profession: Decodable {
    let value: String?
}

struct BirthPlace: Decodable {
    let value: String?
}
