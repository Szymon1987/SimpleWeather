//
//  HapticFeedbackHelper.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 07/04/2022.
//

import UIKit

struct HapticFeedback {
    static func playLightImpact() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
