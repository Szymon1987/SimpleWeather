//
//  WeatherModel.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 06/04/2022.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let conditionId: Int
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
                      
    var conditionName: String {
        switch conditionId {
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


//struct WeatherViewModel {
//    let cityName: String
//    let temperature: String
//    let conditionName: String
//
//    init(weather: WeatherModel){
//        cityName = weather.cityName
//        temperature = String(format: "%.1f", weather.temperature)
//        conditionName = weather.conditionName
//    }
//}
