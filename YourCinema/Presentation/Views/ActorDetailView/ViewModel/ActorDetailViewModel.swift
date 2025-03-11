//
//  ActorDetailViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 25.02.2025.
//

import UIKit

final class ActorDetailViewModel: ObservableObject {
    @Published var person: PersonEntity? = nil
    @Published var error: NetworkError? = nil
    @Published var image: UIImage? = nil
    
    private let personDetailUseCase: PersonDetailUseCase
    
    init(personDetailUseCase: PersonDetailUseCase) {
        self.personDetailUseCase = personDetailUseCase
    }
    
    @MainActor
    func fetchPersonDetail(from id: Int) async {
        do {
            person = try await personDetailUseCase.execute(id)
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknownError(0)
        }
    }
}
