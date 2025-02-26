//
//  DetailViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import UIKit

final class DetailViewModel: ObservableObject {
    @Published var movie: MovieDetailEntity? = nil
    @Published var error: NetworkError? = nil
    @Published var image: UIImage? = nil
    
    private let movieDetailUseCase: DetailMovieUseCase
    
    init(movieDetailUseCase: DetailMovieUseCase) {
        self.movieDetailUseCase = movieDetailUseCase
    }
    
    @MainActor
    func fetchDetailMovie(from id: Int) async {
        do {
            movie = try await movieDetailUseCase.execute(id)
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknownError(0)
        }
    }
}
