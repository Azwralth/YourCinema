//
//  ImageRepositoryImpl.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import Foundation

final class ImageRepositoryImpl: ImageRepository {
    private let networkManager: ImageApi

    init(networkManager: ImageApi) {
        self.networkManager = networkManager
    }

    func fetchImage(from url: URL) async throws -> Data {
        return try await networkManager.fetchImage(from: url)
    }
}
