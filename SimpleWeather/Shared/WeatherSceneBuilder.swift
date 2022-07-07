//
//  WeatherSceneBuilder.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

import UIKit

class WeatherSceneBuilder {
    static func build() -> WeatherViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let weatherViewController = storyboard.instantiateInitialViewController() as! WeatherViewController
        let presenter = WeatherPresenter(output: WeakRef(object: weatherViewController))

        let weatherAPIBaseURLString = WeatherAPIStrings.openWeatherBaseUrl + WeatherAPIStrings.openWeatherApiKey + WeatherAPIStrings.inCelcius
        let locationManager = CoreLocationLocationManager()
        let weatherAPIManager = URLSessionWeatherAPIManager(urlString: weatherAPIBaseURLString)
        let weatherAPIManagerDecoratedWithMainThread = MainThreadDecorator(weatherAPIManager)
        let interactor = WeatherInteractor(locationManager: locationManager,
                                           apiManager: weatherAPIManagerDecoratedWithMainThread,
                                           presenter: presenter)
        weatherViewController.interactor = interactor
        return weatherViewController
    }
}




