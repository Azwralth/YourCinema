//
//  VideoPlayerView.swift
//  YourCinema
//
//  Created by Владислав Соколов on 19.02.2025.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let videoURL: String
    @Environment(\.dismiss) private var dismiss
    @State private var player: AVPlayer?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let player = player {
                VideoPlayer(player: player)
                    .ignoresSafeArea()
                    .onAppear {
                        player.play()
                    }
            } else {
                ProgressView()
            }

            Button(action: {
                player?.pause()
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(.top, 20)
            .padding(.trailing, 20)
        }
        .onAppear {
            if let url = URL(string: videoURL) {
                player = AVPlayer(url: url)
            }
        }
    }
}
