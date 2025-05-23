//
//  ServerApi.swift
//  YourCinema
//
//  Created by Владислав Соколов on 05.02.2025.
//

import SwiftUI

protocol ServerApi {
    func fetch<T: Decodable>(type: T.Type, from endpoint: EndpointProtocol) async throws -> T
}


final class NetworkManager: ServerApi {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(type: T.Type, from endpoint: EndpointProtocol) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        try validateResponse(httpResponse)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
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
