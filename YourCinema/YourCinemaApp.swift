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
    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                AuthView()
                    .environmentObject(appCoordinator)
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                            .environmentObject(appCoordinator)
                            .environmentObject(imageViewModel)
                    }
            }
        }
    }
}
