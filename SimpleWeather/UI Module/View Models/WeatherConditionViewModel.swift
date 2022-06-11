//
//  WeatherConditionViewModel.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import Foundation

struct WeatherConditionViewModel {
    let cityName: String
    let temperature: String
    let weatherConditionIconName: String
    
    init(model: WeatherModel) {
        cityName = model.cityName
        temperature = String(format: "%.1f", model.temperature)
        weatherConditionIconName = WeatherConditionViewModel.iconNameForConditionID(model.conditionId)
    }
    
    //MARK: - Helpers
    static func iconNameForConditionID(_ conditionID: Int) -> String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...884:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
