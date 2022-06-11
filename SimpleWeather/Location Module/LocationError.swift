//
//  LocationError.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import Foundation

enum LocationError: LocalizedError {
    case deniedAccess
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .deniedAccess:
            return "Allow 'SimpleWeather' to access yout location in the device Settings"
        case .unknown:
            return  "Error fetching location. Please try again"
        }
    }
}
