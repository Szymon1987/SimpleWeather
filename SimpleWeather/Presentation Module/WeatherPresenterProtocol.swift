//
//  WeatherPresenterProtocol.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 12/06/2022.
//

import Foundation

protocol WeatherPresenterProtocol {
    func presentError(_ error: LocalizedError)
    func presentWeatherData(model: WeatherModel)
    func provideFeedbackForTappingCurrentLocationButton()
    func provideFeedbackForSearchRequest()
}
