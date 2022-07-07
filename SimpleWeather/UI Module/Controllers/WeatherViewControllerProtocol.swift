//
//  WeatherViewControllerProtocol.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import Foundation

protocol WeatherViewControllerProtocol {
    func triggerLightHapticFeedback()
    func showSpinner()
    func hideSpinner()
    func updateWeatherDataInUI(with viewModel: WeatherConditionViewModel)
    func showErrorAlert(_ error: LocalizedError)
    func clearSearchTextField()
}
