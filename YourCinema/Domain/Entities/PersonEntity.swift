//
//  PersonEntity.swift
//  YourCinema
//
//  Created by Владислав Соколов on 24.02.2025.
//

import Foundation

struct PersonEntity: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let photo: String?
    let description: String
}
