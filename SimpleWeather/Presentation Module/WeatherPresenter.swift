//
//  WeatherPresenter.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 12/06/2022.
//

import Foundation

class WeatherPresenter {
    //QUESTION: Does it have to always be some kind of viewcontroller? Maybe we should change the name of this property for "view" for example?
//    private let viewController: WeatherViewControllerProtocol
    weak var viewController: WeatherViewControllerProtocol!
    // I added the initializer here as I think it is better practice to pass the viewController here as a dependency. That way the output property can be "private let"
    init(output: WeatherViewControllerProtocol) {
        self.viewController = output
    }
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
