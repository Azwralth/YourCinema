//
//  ServerApi.swift
//  YourCinema
//
//  Created by Владислав Соколов on 05.02.2025.
//

import SwiftUI

protocol ServerApi {
    func fetch<T: Decodable>(type: T.Type, from endpoint: EndpointProtocol) async throws -> T
    func fetchImage(from url: URL) async throws -> Data
}
