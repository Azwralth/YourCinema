//
//  ImageApi.swift
//  YourCinema
//
//  Created by Владислав Соколов on 20.02.2025.
//

import Foundation

protocol ImageApi {
    func fetchImage(from url: URL) async throws -> Data
}

final class NetworkImageManager: ImageApi {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(for: URLRequest(url: url))
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        try validateResponse(httpResponse)
        
        return data
    }
    
    private func validateResponse(_ response: HTTPURLResponse) throws {
            switch response.statusCode {
            case 200...299:
                return
            case 400...499:
                throw NetworkError.clientError(response.statusCode)
            case 500...599:
                throw NetworkError.serverError(response.statusCode)
            default:
                throw NetworkError.unknownError(response.statusCode)
            }
        }
}
