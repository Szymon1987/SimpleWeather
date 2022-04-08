//
//  WeatherManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 06/04/2022.
//

import UIKit
import CoreLocation

enum ServiceError {
    case network
    case json
}

protocol WeatherServiceDelegate {
    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherModel)
    func didFailWithError(_ weatherService: WeatherService, error: ServiceError)
}

struct WeatherService {

    private let url = API.openWeatherBaseUrl + API.openWeatherApiKey + "&units=metric"
    
    var delegate: WeatherServiceDelegate?
    
    public func fetchWeather(for cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        performRequest(for: urlString)
    }

    public func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(for: urlString)
    }
    
    private func performRequest(for urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.delegate?.didFailWithError(self, error: ServiceError.network)
                    print(error)
                }
                if let data = data {
                    if let weather = parseJSON(with: data) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }

    private func parseJSON(with data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedWeatherData = try decoder.decode(WeatherData.self, from: data)
            let name = decodedWeatherData.name
            let temp = decodedWeatherData.main.temp
            let id = decodedWeatherData.weather[0].id
            let weaterModel = WeatherModel(cityName: name, temperature: temp, conditionId: id)
            return weaterModel
        } catch {
            print(error)
            delegate?.didFailWithError(self, error: ServiceError.json)
        }
        return nil
    }
}
