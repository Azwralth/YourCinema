//
//  ActorDetailMovieCell.swift
//  YourCinema
//
//  Created by Владислав Соколов on 26.02.2025.
//

import SwiftUI

struct ActorDetailMovieCell: View {
    let movie: MovieEntity
    let id: Int
    var body: some View {
        VStack {
            Image("movie")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 7))
            
            
            Text(movie.title)
                .lineLimit(1)
                .customFont(type: .gilroyExtraBold, size: 19)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.horizontal, 9)
                .padding(.bottom, 6)
        }
        .background(Color.backgroundCell.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            Color.strokeCell.clipShape(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2))
        }
    }
}

#Preview {
    ActorDetailMovieCell(movie: MovieEntity(id: 1345, title: "Avangers The End", duration: 183, description: "123123123", posterUrl: "https://image.openmoviedb.com/kinopoisk-images/1600647/ae22f153-9715-41bb-adb4-f648b3e16092/orig", ageRating: 14, genres: ["action"]), id: 455)
}
