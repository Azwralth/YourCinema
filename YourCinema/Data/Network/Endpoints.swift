//
//  Endpoints.swift
//  YourCinema
//
//  Created by Владислав Соколов on 05.02.2025.
//

import Foundation

struct CinemaId: EndpointProtocol {
    let id: Int
    
    var path: String {
        "/movie/\(id)"
    }
    var parameters: [String : Any]?
}

struct MainViewCinema: EndpointProtocol {
    let page: Int
    var path: String {
        "/movie"
    }
    
    var parameters: [String : Any]? {
        ["page": "\(page)", "limit": "30", "type": "movie", "rating.kp": "8-10"]
    }
}

struct SearchCinema: EndpointProtocol {
    let name: String
    
    var path: String {
        "/movie/search"
    }
    
    var parameters: [String : Any]? {
        ["page": "1", "limit": "1", "query": name]
    }
}
