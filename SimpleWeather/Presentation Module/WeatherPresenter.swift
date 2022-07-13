//
//  WeatherPresenter.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 12/06/2022.
//

import Foundation

class WeatherPresenter {
    
    private let view: WeatherViewControllerProtocol

    init(output: WeatherViewControllerProtocol) {
        self.view = output
    }
}

extension WeatherPresenter: WeatherPresenterProtocol {
    func presentError(_ error: LocalizedError) {
        view.showErrorAlert(error)
        view.hideSpinner()
    }
    
    func presentWeatherData(model: WeatherModel) {
        let viewModel = WeatherConditionViewModel(model: model)
        view.updateWeatherDataInUI(with: viewModel)
        view.hideSpinner()
    }
    
    func provideFeedbackForTappingCurrentLocationButton() {
        view.clearSearchTextField()
        presentLoadingState()
    }
    
    func provideFeedbackForSearchRequest() {
        presentLoadingState()
    }
    
    //MARK: - Helper
    private func presentLoadingState() {
        view.triggerLightHapticFeedback()
        view.showSpinner()
    }
}
