//
//  WeatherAPIManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 10/06/2022.
//

import Foundation

protocol WeatherAPIManager {
    func fetchWeatherData(for cityName: String, completion: )
    func fetchWeatherData(for location: Location)
}
