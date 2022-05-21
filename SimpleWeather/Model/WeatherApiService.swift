//
//  WeatherManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 06/04/2022.
//

import UIKit
import CoreLocation

protocol WeatherService {
    func fetchWeather(for cityName: String)
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    var weatherServiceResponse: (((Result<WeatherModel, WeatherError>)) -> Void)? { get set }
}

class WeatherApiService: WeatherService {

    var weatherServiceResponse: (((Result<WeatherModel, WeatherError>)) -> Void)?
    
    // should this have "client property", so we could inject fake client to test it???? YT

    private let urlString = API.openWeatherBaseUrl + API.openWeatherApiKey + API.inCelcius
    
    
    func fetchWeather(for cityName: String) {
        let endpoint = "\(urlString)&q=\(cityName)"
        performRequest(for: endpoint)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let endpoint = "\(urlString)&lat=\(latitude)&lon=\(longitude)"
        performRequest(for: endpoint)
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
