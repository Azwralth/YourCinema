//
//  ActorDetailMovieCellViewModel.swift
//  YourCinema
//
//  Created by Владислав Соколов on 27.02.2025.
//

import SwiftUI
import UIKit

final class ActorDetailMovieCellViewModel: ObservableObject {
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
