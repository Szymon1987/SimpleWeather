//
//  WeatherSceneBuilder.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 11/06/2022.
//

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
//        let presenter = WeatherPresenter(output: WeakRef(object: weatherViewController))
        let presenter = WeatherPresenter(output: weatherViewController)
        
        weatherViewController.interactor = interactor
        interactor.presenter = presenter
//        presenter.viewController = weatherViewController
        
        return weatherViewController
    }
}














class WeakRef: WeatherViewControllerProtocol {
    func triggerLightHapticFeedback() {
        
    }
    
    func showSpinner() {
        
    }
    
    func hideSpinner() {
        
    }
    
    func updateWeatherDataInUI(with viewModel: WeatherConditionViewModel) {
        
    }
    
    func showErrorAlert(_ error: LocalizedError) {
        
    }
    
    func clearSearchTextField() {
        
    }
    
    weak var object: (AnyObject & WeatherViewControllerProtocol)?
    
    init(object: (AnyObject & WeatherViewControllerProtocol)) {
        self.object = object
    }
}
