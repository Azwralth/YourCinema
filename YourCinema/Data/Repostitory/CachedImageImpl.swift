//
//  CachedImageImpl.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import Foundation

final class CachedImageRepository: ImageRepository {
    private let networkManager: ServerApi
    private let cache = NSCache<NSURL, NSData>()
    
    init(networkManager: ServerApi) {
        self.networkManager = networkManager
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        let nsURL = url as NSURL
        
        if let cachedData = cache.object(forKey: nsURL) {
            return cachedData as Data
        }
        
        let imageData = try await networkManager.fetchImage(from: url)
        
        cache.setObject(imageData as NSData, forKey: nsURL)
        
        return imageData
    }
}
