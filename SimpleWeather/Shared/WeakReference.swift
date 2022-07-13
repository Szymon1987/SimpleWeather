//
//  WeakReference.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 07/07/2022.
//

import Foundation

// NOTICE: WeakRef implemented only for practice purposes

class WeakRef<T: AnyObject> {
    
    weak var object: T?
    
    init(object: T) {
        self.object = object
    }
}

extension WeakRef: WeatherViewControllerProtocol where T: WeatherViewControllerProtocol {
    func triggerLightHapticFeedback() {
        object?.triggerLightHapticFeedback()
    }
    
    func showSpinner() {
        object?.showSpinner()
    }
    
    func hideSpinner() {
        object?.hideSpinner()
    }
    
    func updateWeatherDataInUI(with viewModel: WeatherConditionViewModel) {
        object?.updateWeatherDataInUI(with: viewModel)
    }
    
    func showErrorAlert(_ error: LocalizedError) {
        object?.showErrorAlert(error)
    }
    
    func clearSearchTextField() {
        object?.clearSearchTextField()
    }
}
