//
//  ImageRepository.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import Foundation

protocol ImageRepository {
    func fetchImage(from url: URL) async throws -> Data
}
