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
    var weatherServiceResponse: ((Result<WeatherModel, WeatherError>) -> Void)? { get set }
    
}

class WeatherApiService: WeatherService {
   
    
    // should this have "client property", so we could inject fake client to test it???? YT

    private let urlString = WeatherServiceApiStrings.openWeatherBaseUrl + WeatherServiceApiStrings.openWeatherApiKey + WeatherServiceApiStrings.inCelcius
    
    var weatherServiceResponse: ((Result<WeatherModel, WeatherError>) -> Void)?
    
    
    func fetchWeather(for cityName: String) {
        let endpoint = "\(urlString)&q=\(cityName)"
        performRequest(for: endpoint)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let endpoint = "\(urlString)&lat=\(latitude)&lon=\(longitude)"
        performRequest(for: endpoint)
    }
   
    
//    func fetchWeather(for cityName: String, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
//        let endpoint = "\(urlString)&q=\(cityName)"
//        guard let url = URL(string: endpoint) else {
//            return
//        }
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if let _ = error {
//                    completion(.failure(.unableToComplete))
//                }
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    completion(.failure(.invalidCityName))
//                    return
//                }
//                guard let data = data else {
//                    completion(.failure(.invalidData))
//                    return
//                }
//                do {
//                    let decodedWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                    let name = decodedWeatherData.name
//                    let temp = decodedWeatherData.main.temp
//                    let id = decodedWeatherData.weather[0].id
//
//                    let weatherModel = WeatherModel(cityName: name, temperature: temp, conditionId: id)
//                    completion(.success(weatherModel))
//                } catch {
//                    completion(.failure(.invalidData))
//                }
//            }
//            task.resume()
//
//    }

//    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherModel, WeatherError>) -> Void) {
//        let endpoint = "\(urlString)&lat=\(latitude)&lon=\(longitude)"
//        guard let url = URL(string: endpoint) else {
//            return
//        }
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if let _ = error {
//                    completion(.failure(.unableToComplete))
//                }
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    completion(.failure(.invalidCityName))
//                    return
//                }
//                guard let data = data else {
//                    completion(.failure(.invalidData))
//                    return
//                }
//                do {
//                    let decodedWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
//                    let name = decodedWeatherData.name
//                    let temp = decodedWeatherData.main.temp
//                    let id = decodedWeatherData.weather[0].id
//
//                    let weatherModel = WeatherModel(cityName: name, temperature: temp, conditionId: id)
//                    completion(.success(weatherModel))
//                } catch {
//                    completion(.failure(.invalidData))
//                }
//            }
//            task.resume()
//    }


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
