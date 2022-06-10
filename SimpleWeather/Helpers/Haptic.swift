//
//  Hapic.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 07/04/2022.
//

import UIKit

struct Haptics {
    static func playLightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
