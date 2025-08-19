//
//  AppDelegate.swift
//  YourCinema
//
//  Created by Владислав on 19.08.2025.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAPIKey()
        FirebaseApp.configure()
        
        return true
    }
    
    private func setupAPIKey() {
        let apiKey = "MWA2GMK-VJ848ZV-Q53E564-5HNA763"
        
        if KeychainManager.get(key: "apiKey") == nil {
            KeychainManager.save(key: "apiKey", value: apiKey)
            print("API-ключ сохранен в Keychain")
        } else {
            print("API-ключ уже сохранен")
        }
    }
}
