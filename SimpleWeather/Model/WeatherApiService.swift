//
//  WeatherManager.swift
//  SimpleWeather
//
//  Created by Szymon Tadrzak on 06/04/2022.
//

import UIKit
import CoreLocation

enum Result {
    case success(Data)
    case failure(Error)
}

//protocol WeatherServiceDelegate {
//    func didUpdateWeather(_ weatherService: WeatherService, weather: WeatherViewModel)
//    func didFailWithError(_ weatherService: WeatherService, error: ServiceError)
//}

protocol WeatherService {
    func fetchWeather(for cityName: String)
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class WeatherApiService: WeatherService {
    
    enum ServiceError {
        case network
        case json
    }
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
                    self.weatherFailureClosure?(error)
                    print(error)
                }
                if let data = data {
                    self.parseJSON(with: data) { weatherViewModel in
                        self.weatherSuccessClosure?(weatherViewModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    var weatherSuccessClosure: ((WeatherViewModel) -> Void)?
    var weatherFailureClosure: ((Error) -> Void)?
    
    
    
    
    
    
    
//    var delegate: WeatherServiceDelegate?
//
//    public func fetchWeather(for cityName: String) {
//        let urlString = "\(url)&q=\(cityName)"
////        performRequest(for: urlString)
//
//    }
//
//    public func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "\(url)&lat=\(latitude)&lon=\(longitude)"
////        performRequest(for: urlString)
//    }
    
//    private func performRequest(for urlString: String, completion: @escaping (Result) -> Void) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    completion(.failure(ServiceError.network))
////                    self.delegate?.didFailWithError(self, error: ServiceError.network)
//                    print(error)
//                }
//                if let data = data {
////                    if let weather = parseJSON(with: data) {
////                        self.delegate?.didUpdateWeather(self, weather: weather)
//                    completion(.success(data))
//
//                    self.parseJSON(with: data) { viewModel in
////                        self.delegate?.didUpdateWeather(self, weather: viewModel)
//
//                    }
//
////                    }
//
//
//                }
//            }
//            task.resume()
//        }
//    }
// use closure here to send the weather
//    private func parseJSON(with data: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedWeatherData = try decoder.decode(WeatherData.self, from: data)
//            let name = decodedWeatherData.name
//            let temp = decodedWeatherData.main.temp
//            let id = decodedWeatherData.weather[0].id
//            let weaterModel = WeatherModel(cityName: name, temperature: temp, conditionId: id)
//            return weaterModel
//        } catch {
//            print(error)
//            delegate?.didFailWithError(self, error: ServiceError.json)
//        }
//        return nil
//    }
    
    private func parseJSON(with data: Data, completion: (WeatherViewModel) -> Void) {
        let decoder = JSONDecoder()
        do {
            let decodedWeatherData = try decoder.decode(WeatherData.self, from: data)
            let name = decodedWeatherData.name
            let temp = decodedWeatherData.main.temp
            let id = decodedWeatherData.weather[0].id
            // change viewModel for the proper one
            let viewModel = WeatherViewModel(cityName: name, temperature: temp, conditionId: id)
            let dkkd = WeatherViewModel(

            completion(viewModel)
        } catch {
            print(error)
//            delegate?.didFailWithError(self, error: ServiceError.json)
            self.weatherFailureClosure?(error)
        }
    }
}
