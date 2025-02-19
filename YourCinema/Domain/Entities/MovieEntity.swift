//
//  MovieEntity.swift
//  YourCinema
//
//  Created by Владислав Соколов on 05.02.2025.
//

import Foundation

struct MovieEntity: Hashable {
    let title: String
    let duration: Int?
    let description: String
    let posterUrl: String?
    let ageRating: Int?
    let genres: [String]
}



