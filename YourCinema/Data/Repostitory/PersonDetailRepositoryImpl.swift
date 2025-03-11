//
//  PersonDetailRepositoryImpl.swift
//  YourCinema
//
//  Created by Владислав Соколов on 27.02.2025.
//

import Foundation

final class PersonDetailRepositoryImpl: PersonDetailRepository {
    private let networkManager: ServerApi

    init(networkManager: ServerApi) {
        self.networkManager = networkManager
    }
    
    func fetchPerson(id: Int) async throws -> PersonEntity {
        let response = try await networkManager.fetch(type: Actor.self, from: PersonId(id: id))
        return PersonDetailMapper.map(person: response)
    }
}
