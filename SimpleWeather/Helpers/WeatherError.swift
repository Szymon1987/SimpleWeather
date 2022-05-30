//
//  WeatherError.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 21/05/2022.
//

import Foundation

enum WeatherError: String, Error {
    case invalidCityName = "Please enter valid city name."
    case unableToComplete = "Unable to complete the request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again later."
    case locationError = "Error fetching location. Please try again"
    
    
    case allowAccess = "Allow 'SimpleWeather' to access yout location in the device Settings"
}

