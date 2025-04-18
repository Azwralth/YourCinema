//
//  KeychainManager.swift
//  YourCinema
//
//  Created by Владислав Соколов on 05.02.2025.
//

import Security
import UIKit
import FirebaseCore

struct KeychainManager {
    
    static func save(key: String, value: String) {
        let data = value.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    static func get(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status != errSecSuccess { return nil }
        guard let data = result as? Data else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
    
    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAPIKey()
        FirebaseApp.configure()
        
        return true
    }
    
    private func setupAPIKey() {
        let apiKey = "CWCZW7V-VGQMK0M-QHQJ04W-0QG6PFX"
        
        if KeychainManager.get(key: "apiKey") == nil {
            KeychainManager.save(key: "apiKey", value: apiKey)
            print("API-ключ сохранен в Keychain")
        } else {
            print("API-ключ уже сохранен")
        }
    }
}
