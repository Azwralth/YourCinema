//
//  PersonDetailRepository.swift
//  YourCinema
//
//  Created by Владислав Соколов on 27.02.2025.
//

import Foundation

protocol PersonDetailRepository {
    func fetchPerson(id: Int) async throws -> PersonEntity
}
