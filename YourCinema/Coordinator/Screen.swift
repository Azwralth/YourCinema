//
//  Screen.swift
//  YourCinema
//
//  Created by Владислав Соколов on 16.04.2025.
//

import Foundation

enum Screen: Hashable, Identifiable {
    case main
    case movieDetails(Int)
    case actorDetails(Int)
    
    var id: Self { self }
}
