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
    var weatherServiceResponse: (((Result<WeatherModel, Error>)) -> Void)? { get set }
}

class WeatherApiService: WeatherService {

    var weatherServiceResponse: (((Result<WeatherModel, Error>)) -> Void)?
    
    // should this have "client property", so we could inject fake client to test it???? YT

    private let url = API.openWeatherBaseUrl + API.openWeatherApiKey + API.inCelcius
    
    
    func fetchWeather(for cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        performRequest(for: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(url)&lat=\(latitude)&lon=\(longitude)"
        performRequest(for: urlString)
    }
    
    private func performRequest(for urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.weatherServiceResponse?(.failure(error))
                }
                if let data = data {
                    self.parseJSON(with: data)
                }
            }
            task.resume()
        }
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
            print(error)
            self.weatherServiceResponse?(.failure(error))
        }
    }
}
