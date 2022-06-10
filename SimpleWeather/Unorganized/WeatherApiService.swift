//
//  WeatherManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 06/04/2022.
//

import UIKit

protocol WeatherService {
    func fetchWeather(for cityName: String)
    func fetchWeatherForLocation()
    var completion: ((Result<WeatherModel, WeatherError>) -> Void)? { get set }
}

class WeatherApiService: WeatherService {
 
    private let locationProvider: LocationProvider
    private let urlString: String
    
    var completion: ((Result<WeatherModel, WeatherError>) -> Void)?

    init(locationProvider: LocationProvider, urlString: String) {
        self.locationProvider = locationProvider
        self.urlString = urlString
    }
    
    public func fetchWeather(for cityName: String) {
        let endpoint = "\(urlString)&q=\(cityName)"
        performRequest(for: endpoint)
    }
    
    public func fetchWeatherForLocation() {
        locationProvider.provideLocation { result in
            switch result {
            case .success(let location):
                let endpoint = "\(self.urlString)&lat=\(location.latitude)&lon=\(location.longitude)"
                self.performRequest(for: endpoint)
            case .failure(let error):
                        print(error)
                // Handle WeatherError and LocationError here

//                self.completion?(.failure(error))
            }
        }
    }
    
    private func performRequest(for endpoint: String) {
        guard let url = URL(string: endpoint) else {
            self.completion?(.failure(.invalidCityName))
            return
        }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let _ = error {
                    self.completion?(.failure(.unableToComplete))
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    self.completion?(.failure(.invalidCityName))
                    return
                }
                guard let data = data else {
                    self.completion?(.failure(.invalidData))
                    return
                }
                self.parseJSON(with: data)
            }
            task.resume()
    }

    private func parseJSON(with data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedWeatherData = try decoder.decode(WeatherData.self, from: data)
            let name = decodedWeatherData.name
            let temp = decodedWeatherData.main.temp
            let id = decodedWeatherData.weather[0].id
            let weatherModel = WeatherModel(cityName: name, temperature: temp, conditionId: id)
            self.completion?(.success(weatherModel))
        } catch {
            self.completion?(.failure(.invalidData))
        }
    }
}



