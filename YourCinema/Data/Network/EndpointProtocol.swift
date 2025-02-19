//
//  EndpointProtocol.swift
//  YourCinema
//
//  Created by Владислав Соколов on 05.02.2025.
//

import Foundation

protocol EndpointProtocol {
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension EndpointProtocol {
    var baseUrl: URL {
        URL(string: "https://api.kinopoisk.dev/v1.4")!
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String]? {
        ["accept": "application/json",
         "X-API-KEY": "\(KeychainManager.get(key: "apiKey") ?? "")"]
    }
    
    func urlRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let parameters {
            if method == .get {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
                request.url = components?.url
            } else {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            }
        }
        
        return request
    }
}
