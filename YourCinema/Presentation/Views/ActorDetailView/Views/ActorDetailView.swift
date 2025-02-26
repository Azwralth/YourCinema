//
//  ActorDetailView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 25.02.2025.
//

import SwiftUI

struct ActorDetailView: View {
    @StateObject private var viewModel = ActorDetailViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var imageViewModel: ImageViewModel
    
    let person: PersonEntity
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.32)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.7),
                                    Color.clear
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .overlay (
                            Color.black.opacity(0.7)
                        )
                        .overlay(
                            Image("detailMask")
                                .resizable()
                                .frame(width: geometry.size.width, height: geometry.size.height / 1.5)
                        )
                        .ignoresSafeArea()
                }
                
                
                VStack(alignment: .leading) {
                                        
                    Text(person.name)
                        .customFont(type: .gilroyExtraBold, size: 44)
                        .foregroundStyle(.white.opacity(0.84))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack(spacing: 16) {
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("4 April, 1965")
                                .customFont(type: .gilroyRegular, size: 14)
                                .foregroundStyle(.white)
                            
                            Text("New York City, New York, U.S.")
                                .customFont(type: .gilroyRegular, size: 14)
                                .foregroundStyle(.white)
                            
                            Text("Actor, producer, singer")
                                .customFont(type: .gilroyRegular, size: 14)
                                .foregroundStyle(.mainRed)
                                
                        }
                    }
                    
                    Text("Filmography")
                        .customFont(type: .gilroyExtraBold, size: 16)
                        .foregroundStyle(.white)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                        ForEach(0..<4) { _ in
                            ActorDetailMovieCell(movie: MovieEntity(id: 1345, title: "Avangers The End", duration: 183, description: "123123123", posterUrl: "https://image.openmoviedb.com/kinopoisk-images/1600647/ae22f153-9715-41bb-adb4-f648b3e16092/orig", ageRating: 14, genres: ["action"]), id: 1343)
                                .frame(width: geometry.size.width / 3.3, height: geometry.size.height / 4.5)
                            }
                        }
                        .padding(.horizontal, 8)
                    }
                    
                    Text("Biography")
                        .customFont(type: .gilroyExtraBold, size: 16)
                        .foregroundStyle(.white)
                        .padding(.top, 24)
                        .padding(.bottom, 8)
                    
                    Text(person.description)
                        .customFont(type: .gilroyLight, size: 16)
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(.top, 96)
                .padding(.horizontal, 16)
            }
            .onAppear {
                Task {
                    if let imageUrl = person.photo {
                        viewModel.image = await imageViewModel.fetchImage(from: imageUrl)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.gray)
                            Text("Back")
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .background {
                Image("BG")
            }
        }
    }
}

//#Preview {
//    ActorDetailView(person: PersonEntity(name: "", photo: "", description: ""))
//}
