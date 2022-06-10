//
//  WeatherError.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 21/05/2022.
//

import Foundation

enum WeatherError: LocalizedError {
    case invalidCityName
    case unableToComplete
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidCityName:
            return "Please enter valid city name."
        case .unableToComplete:
            return "Unable to complete the request. Please check your internet connection."
        case .invalidResponse:
            return "Unable to complete the request. Please try again later."
        case .invalidData:
            return "The data received from the server was invalid. Please try again later."
        }
    }
}

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
