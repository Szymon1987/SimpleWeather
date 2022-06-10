//
//  WeatherInteractor.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 10/06/2022.
//

import Foundation

class WeatherInteractor {
    let locationManager: LocationManager
    let apiManager: WeatherAPIManager
    
    internal init(locationManager: LocationManager, apiManager: WeatherAPIManager) {
        self.locationManager = locationManager
        self.apiManager = apiManager
    }

    private func processhWeatherDataFor(_ result: Result<Location, LocationError>) {
        switch result {
        case let .success(location):
            apiManager.fetchWeatherData(for: loc)
            break
        case .failure(_):
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
        locationManager.requestLocation { [weak self] result in
            if self != nil { self!.processhWeatherDataFor(result) }
        }
    }
    
    func didSearchForCity(withName name: String) {
        
    }
}
