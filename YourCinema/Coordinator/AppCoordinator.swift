//
//  AppCoordinator.swift
//  YourCinema
//
//  Created by Владислав Соколов on 16.04.2025.
//

import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get }
    
    func pop()
    func popToRoot()
    func push(_ screen: Screen)
}

final class AppCoordinator: AppCoordinatorProtocol {
    @Published var path = NavigationPath()

    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .main:
            MovieView()
        case .movieDetails(let int):
            DetailView(id: int)
        case .actorDetails(let int):
            ActorDetailView(id: int)
        }
    }
}
