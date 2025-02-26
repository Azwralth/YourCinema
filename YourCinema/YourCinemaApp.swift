//
//  YourCinemaApp.swift
//  YourCinema
//
//  Created by Владислав Соколов on 05.02.2025.
//

import SwiftUI

@main
struct YourCinemaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var imageViewModel = ImageViewModel(imageRepository: ImageRepositoryImpl(networkManager: NetworkImageManager()))
    
    var body: some Scene {
        WindowGroup {
            MovieView()
                .environmentObject(imageViewModel)
        }
    }
}
