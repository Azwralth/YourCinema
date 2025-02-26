//
//  ImageViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 25.02.2025.
//

import SwiftUI

final class ImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var error: NetworkError?

    private let imageRepository: ImageRepository

    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }

    @MainActor
    func fetchImage(from url: String) async -> UIImage? {
        guard let url = URL(string: url), url.scheme != nil else {
            return nil
        }
        do {
            let imageData = try await imageRepository.fetchImage(from: url)
            return UIImage(data: imageData)
        } catch {
            return nil
        }
    }
}
