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
    
    var body: some Scene {
        WindowGroup {
            MovieView()
        }
    }
}
