//
//  WeatherModel.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    typealias Celcius = Double
    let temp: Celcius
}

struct Weather: Decodable {
    let description: String
    let id: Int
}

