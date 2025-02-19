//
//  DetailViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import UIKit

final class DetailViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var error: NetworkError?
    
    private let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    @MainActor
    func fetchImage(from url: String) async {
        guard let url = URL(string: url) else { return }
        
        do {
            let imageData = try await imageRepository.fetchImage(from: url)
            self.image = UIImage(data: imageData)
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknownError(0)
        }
    }
}

