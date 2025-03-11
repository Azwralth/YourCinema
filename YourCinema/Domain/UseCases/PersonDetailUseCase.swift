//
//  PersonDetailUseCase.swift
//  YourCinema
//
//  Created by Владислав Соколов on 27.02.2025.
//

import Foundation

final class PersonDetailUseCase {
    private let repository: PersonDetailRepository
    
    init(repository: PersonDetailRepository) {
        self.repository = repository
    }
    
    func execute(_ id: Int) async throws -> PersonEntity {
        let person = try await repository.fetchPerson(id: id)
        return person
    }
}
