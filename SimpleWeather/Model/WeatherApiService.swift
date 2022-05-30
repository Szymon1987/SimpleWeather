//
//  WeatherManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 06/04/2022.
//

import UIKit

protocol WeatherService {
    func fetchWeather(for cityName: String)
    func fetchWeather()
    var weatherServiceResponse: ((Result<WeatherModel, WeatherError>) -> Void)? { get set }
}

class WeatherApiService: WeatherService {
   
    private let locationService: LocationService
    private let urlString: String
    
    var weatherServiceResponse: ((Result<WeatherModel, WeatherError>) -> Void)?

    init(locatinService: LocationService, urlString: String) {
        self.locationService = locatinService
        self.urlString = urlString
    }
    
    func fetchWeather(for cityName: String) {
        let endpoint = "\(urlString)&q=\(cityName)"
        performRequest(for: endpoint)
    }
    
    public func fetchWeather() {
        locationService.requestLocation()
        locationService.actionForLocation = { result in
            switch result {
            case .success(let location):
                let endpoint = "\(self.urlString)&lat=\(location.latitude)&lon=\(location.longitude)"
                self.performRequest(for: endpoint)
            case .failure(let error):
                self.weatherServiceResponse?(.failure(error))
            }
        }
    }
    
    private func performRequest(for endpoint: String) {

        guard let url = URL(string: endpoint) else {
            return
        }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let _ = error {
                    self.weatherServiceResponse?(.failure(.unableToComplete))
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    self.weatherServiceResponse?(.failure(.invalidCityName))
                    return
                }
                guard let data = data else {
                    self.weatherServiceResponse?(.failure(.invalidData))
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
            self.weatherServiceResponse?(.success(weatherModel))
        } catch {
            self.weatherServiceResponse?(.failure(.invalidData))
        }
    }
}

