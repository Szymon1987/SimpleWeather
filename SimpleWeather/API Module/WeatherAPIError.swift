//
//  WeatherAPIError.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import Foundation

enum WeatherAPIError: LocalizedError {
    case invalidCityName
    case invalidLocation
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
        case .invalidLocation:
            return "The location cannot be retrieved properly."
        }
    }
}
