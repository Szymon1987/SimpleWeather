//
//  WeatherAPIManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 10/06/2022.
//

import Foundation

protocol WeatherAPIManager {
    typealias WeatherAPICompletionBlock = (Result<WeatherModel, WeatherAPIError>) -> Void
    
    func fetchWeatherData(for cityName: String, completion: @escaping WeatherAPICompletionBlock)
    func fetchWeatherData(for location: Location, completion: @escaping WeatherAPICompletionBlock)
}
