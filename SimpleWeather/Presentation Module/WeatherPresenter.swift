//
//  WeatherPresenter.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 12/06/2022.
//

import Foundation

class WeatherPresenter {
    weak var viewController: WeatherViewControllerProtocol!
}

extension WeatherPresenter: WeatherPresenterProtocol {
    func presentError(_ error: LocalizedError) {
        viewController.showErrorAlert(error)
        viewController.hideSpinner()
    }
    
    func presentWeatherData(model: WeatherModel) {
        let viewModel = WeatherConditionViewModel(model: model)
        viewController.updateWeatherDataInUI(with: viewModel)
        viewController.hideSpinner()
    }
    
    func provideFeedbackForTappingCurrentLocationButton() {
        viewController.clearSearchTextField()
        presentLoadingState()
    }
    
    func provideFeedbackForSearchRequest() {
        presentLoadingState()
    }
    
    //MARK: - Helper
    private func presentLoadingState() {
        viewController.triggerLightHapticFeedback()
        viewController.showSpinner()
    }
}
