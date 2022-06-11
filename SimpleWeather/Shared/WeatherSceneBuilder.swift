//
//  WeatherSceneBuilder.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import Foundation
import UIKit

class WeatherSceneBuilder {
    static func build() -> WeatherViewController {
        let weatherAPIBaseURLString = WeatherAPIStrings.openWeatherBaseUrl + WeatherAPIStrings.openWeatherApiKey + WeatherAPIStrings.inCelcius
        let locationManager = CoreLocationLocationManager()
        let weatherAPIManager = URLSessionWeatherAPIManager(urlString: weatherAPIBaseURLString)
        let interactor = WeatherInteractor(locationManager: locationManager,
                                           apiManager: weatherAPIManager)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let weatherViewController = storyboard.instantiateInitialViewController() as! WeatherViewController
        weatherViewController.interactor = interactor
        interactor.viewController = weatherViewController
        return weatherViewController
    }
}