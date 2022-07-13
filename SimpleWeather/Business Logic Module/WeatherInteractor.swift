//
//  WeatherInteractor.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 10/06/2022.
//

import Foundation

class WeatherInteractor {
    
    private let locationManager: LocationManager
    private let apiManager: WeatherAPIManager
    
    private let presenter: WeatherPresenterProtocol
    
    internal init(locationManager: LocationManager, apiManager: WeatherAPIManager, presenter: WeatherPresenterProtocol) {
        self.locationManager = locationManager
        self.apiManager = apiManager
        self.presenter = presenter
    }

    private func processhWeatherDataFor(_ locationRequestResult: Result<Location, LocationError>) {
        switch locationRequestResult {
        case let .success(location):
            apiManager.fetchWeatherData(for: location, completion: { [weak self] weatherAPIResponse in
                if let self = self {
                    self.processWeatherAPIResponse(weatherAPIResponse)
                }
            })
            break
        case let .failure(error):
            presenter.presentError(error)
            break
        }
    }
    
    private func processWeatherAPIResponse(_ response: Result<WeatherModel, WeatherAPIError>) {
        switch response {
        case let .success(weatherModel):
            presenter.presentWeatherData(model: weatherModel)
            break
        case let .failure(error):
            presenter.presentError(error)
            break
        }
    }
}


extension WeatherInteractor: WeatherInteractorProtocol {
    func viewDidLoad() {
        locationManager.requestLocation { [weak self] result in
            if self != nil { self!.processhWeatherDataFor(result) }
        }
    }
    
    func didPressTheCurrentLocationButton() {
        presenter.provideFeedbackForTappingCurrentLocationButton()
        locationManager.requestLocation { [weak self] result in
            if self != nil { self!.processhWeatherDataFor(result) }
        }
    }
    
    func didSearchForCity(withName cityName: String) {
        if (cityName != "") {
            let trimmedCityName = cityName.trimmingCharacters(in: .whitespaces)
            presenter.provideFeedbackForSearchRequest()
            apiManager.fetchWeatherData(for: trimmedCityName, completion: { [weak self] weatherAPIResponse in
                if let self = self {
                    self.processWeatherAPIResponse(weatherAPIResponse)
                }
            })
        }
    }
}
