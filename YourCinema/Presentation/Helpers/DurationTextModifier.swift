//
//  DurationTextModifier.swift
//  YourCinema
//
//  Created by Владислав Соколов on 25.02.2025.
//

import SwiftUI

struct DurationFormatter {
    static func format(minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        
        var result = ""
        if hours > 0 {
            result += "\(hours) " + (hours == 1 ? "час" : "часа")
        }
        if mins > 0 {
            if !result.isEmpty {
                result += " "
            }
            result += "\(mins) мин"
        }
        
        return result.isEmpty ? "0 минут" : result
    }
}

