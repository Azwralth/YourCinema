//
//  File.swift
//  YourCinema
//
//  Created by Владислав on 19.08.2025.
//

import UIKit

extension UIApplication {
    var currentUIWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
    
    var screenWidth: CGFloat {
        currentUIWindow?.bounds.width ??
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.screen.bounds.width ?? 0
    }
    
    var screenSize: CGSize {
        currentUIWindow?.bounds.size ??
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.screen.bounds.size ?? .zero
    }
}
