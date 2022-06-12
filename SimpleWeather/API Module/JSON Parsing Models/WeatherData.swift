//
//  WeatherModel.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 05/04/2022.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let stats: WeatherStatistics
    let condition: [WeatherCondition]
    
    enum CodingKeys: String, CodingKey {
        case name      = "name"
        case stats     = "main"
        case condition = "weather"
    }
    
    var weatherModel: WeatherModel {
        return WeatherModel(cityName: name, temperature: stats.temperature, conditionId: condition[0].id)
    }
}

struct WeatherStatistics: Decodable {
    typealias Celcius = Double
    let temperature: Celcius
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}

struct WeatherCondition: Decodable {
    let id: Int
    let title: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id          = "id"
        case title       = "main"
        case description = "description"
    }
}

